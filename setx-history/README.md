# Southeast Texas History

AI-powered chat agent for exploring Southeast Texas history and heritage.

## Quick Start (Docker - Recommended)

```bash
docker-compose up -d
```

Visit http://localhost:3002

## Quick Start (Manual)

```bash
npm install
./start.sh
```

## Features

- Chat with AI historian about Southeast Texas
- Database of historical facts, cities, topics, and periods
- Learning system that captures new historical insights from conversations
- Ollama cloud API integration

## Docker Commands

```bash
# Start
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down

# Rebuild
docker-compose up -d --build
```

## API Endpoints

- `GET /api/cities` - List all cities
- `GET /api/topics` - List all topics
- `GET /api/facts` - List all historical facts
- `GET /api/periods` - List all historical periods
- `POST /api/conversation` - Create new conversation
- `POST /api/chat` - Send message to AI historian

## Configuration

Set environment variables in `docker-compose.yml` or `.env`:

```
OLLAMA_URL=https://ollama.com
OLLAMA_API_KEY=your-api-key-here
OLLAMA_MODEL=gpt-oss:20b-cloud
```
