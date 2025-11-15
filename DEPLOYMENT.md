# SETX Events Deployment Instructions

## Prerequisites

1. Node.js 18+ installed
2. Ollama CLI installed
3. PM2 or similar process manager (recommended)

## Setup Steps

### 1. Install Dependencies

```bash
cd setx-events
npm install
```

### 2. Authenticate with Ollama Cloud

**IMPORTANT:** You must authenticate with Ollama cloud before the chat agent will work.

```bash
ollama login
```

This will prompt you to enter your Ollama API key. Once authenticated, the credentials are stored in `~/.ollama/config.json` and will be used automatically by the chat agent.

You only need to do this once per server.

### 3. Initialize Historical Database

```bash
node history-database.js
```

This creates the historical tables and seeds initial Southeast Texas history data.

### 4. Start the API Server

**Option A: Direct**
```bash
node api-server.js
```

**Option B: With PM2 (Recommended for production)**
```bash
pm2 start api-server.js --name setx-api
pm2 save
pm2 startup
```

The API will run on port 3001.

### 5. Start the Frontend

**Development:**
```bash
cd public
python3 -m http.server 8081
```

**Production with nginx:**
See nginx configuration below.

## Environment Variables (Optional)

While `ollama login` handles authentication, you can override settings with environment variables:

```bash
# Use a different Ollama model
export OLLAMA_MODEL="deepseek-v3.1:671b-cloud"

# Use a different Ollama endpoint (advanced)
export OLLAMA_URL="https://ollama.com"
```

Available cloud models:
- `gpt-oss:20b-cloud` (default, balanced)
- `gpt-oss:120b-cloud` (larger, more capable)
- `deepseek-v3.1:671b-cloud` (very large)
- `qwen3-coder:480b-cloud` (code-focused)
- `kimi-k2:1t-cloud`
- `glm-4.6:cloud`
- `minimax-m2:cloud`

## Nginx Configuration (Production)

```nginx
server {
    listen 80;
    server_name your-domain.com;

    # Frontend
    location / {
        root /path/to/setx-events/public;
        try_files $uri $uri/ /index.html;
    }

    # API
    location /api {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## Verify Deployment

### Check API Health
```bash
curl http://localhost:3001/api/health
```

Expected response:
```json
{"status":"ok","timestamp":"...","database":"connected"}
```

### Check Historical Data
```bash
curl http://localhost:3001/api/history/cities
```

Should return list of Southeast Texas cities.

### Test Chat Agent
```bash
curl -X POST http://localhost:3001/api/history/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Tell me about Spindletop","conversation_id":1}'
```

If you get an error about Ollama not being authenticated, make sure you ran `ollama login`.

## Accessing the Site

Once deployed:
- **Events**: http://your-domain.com/
- **Venues**: http://your-domain.com/venues
- **History Chat**: http://your-domain.com/history
- **Dashboard**: http://your-domain.com/dashboard

## Troubleshooting

### Chat not working?

1. **Check Ollama authentication:**
   ```bash
   ls -la ~/.ollama/config.json
   ```

   If this file doesn't exist, run `ollama login`.

2. **Check server logs:**
   ```bash
   # If using PM2
   pm2 logs setx-api

   # If running directly
   # Check the terminal output
   ```

3. **Verify Ollama model:**
   ```bash
   # Make sure you're using a cloud model (ending in -cloud)
   export OLLAMA_MODEL="gpt-oss:20b-cloud"
   ```

### Database issues?

```bash
# Reset and reinitialize
rm database.sqlite
node history-database.js
```

### Port already in use?

```bash
# Find process using port 3001
lsof -i :3001

# Kill it
kill -9 <PID>
```

## Backup

Regular database backups:
```bash
#!/bin/bash
# backup-db.sh
DATE=$(date +%Y%m%d-%H%M%S)
cp database.sqlite backups/database-$DATE.sqlite
```

Add to cron:
```bash
0 2 * * * /path/to/setx-events/backup-db.sh
```

## Monitoring

With PM2:
```bash
pm2 monit            # Real-time monitoring
pm2 status           # Process status
pm2 logs setx-api    # View logs
pm2 restart setx-api # Restart if needed
```

## Security Notes

- The `.ollama/config.json` file contains your API key - keep it secure
- Consider running the API behind nginx with SSL/TLS
- Set up firewall rules to restrict direct access to port 3001
- Regularly update dependencies: `npm audit fix`

## Support

For issues or questions:
- Check logs first
- Verify `ollama login` was run
- Ensure you're using a `-cloud` model
- Check network connectivity to ollama.com
