#!/bin/bash

# SETX Events - One Command Deployment
# Run this on your server: bash deploy.sh

set -e

echo "🚀 SETX Events Deployment Starting..."
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Initialize historical database
echo "🏛️  Setting up historical database..."
node history-database.js

# Create .env if it doesn't exist
if [ ! -f .env ]; then
    echo "⚙️  Creating .env file..."
    cat > .env << 'EOF'
# Ollama Cloud API Configuration
OLLAMA_URL=https://ollama.com
OLLAMA_API_KEY=6f15669254714b3782a3ca496f117335.Rdkn59O-KUskGeWjfiVux3OQ
OLLAMA_MODEL=gpt-oss:20b-cloud
EOF
    echo "✅ .env created"
else
    echo "✅ .env already exists"
fi

# Check if PM2 is installed
if ! command -v pm2 &> /dev/null; then
    echo "📦 Installing PM2..."
    npm install -g pm2
fi

# Stop existing processes
echo "🛑 Stopping existing processes..."
pm2 stop setx-api 2>/dev/null || true
pm2 delete setx-api 2>/dev/null || true

# Start API server
echo "🚀 Starting API server..."
pm2 start api-server.js --name setx-api
pm2 save

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📊 Service Status:"
pm2 status

echo ""
echo "🌐 Access your site:"
echo "   Events: http://localhost:8081/"
echo "   History: http://localhost:8081/history"
echo "   API: http://localhost:3001/api/health"
echo ""
echo "📝 Next steps:"
echo "   1. Start frontend: cd public && python3 -m http.server 8081"
echo "   2. View logs: pm2 logs setx-api"
echo "   3. Restart API: pm2 restart setx-api"
echo ""
