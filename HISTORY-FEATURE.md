# Southeast Texas History Feature

## Overview

The SETX Events platform now includes a comprehensive historical database and AI-powered chat agent that allows users to explore and learn about Southeast Texas history. This feature turns the platform into not just an events aggregator, but a complete cultural resource for the Golden Triangle region.

## Features

### 1. Historical Database

A rich database of Southeast Texas history including:

- **8 Cities & Towns**: Beaumont, Port Arthur, Orange, Nederland, Port Neches, Groves, Vidor, and Bridge City
- **10 Historical Topics**: Oil & Energy, Lumber Industry, Shipbuilding, Cajun Culture, Native American heritage, Civil War, Hurricanes, Railroad, Education, and Music & Arts
- **9 Historical Periods**: From Pre-Settlement Era to Modern Era (2025)
- **7+ Initial Historical Facts**: Curated facts about major events like Spindletop, lumber boom, WWII shipbuilding, etc.

### 2. AI Chat Agent

An intelligent chat agent powered by Ollama that:

- Answers questions about Southeast Texas history
- Uses the historical database as context for accurate responses
- Engages users in conversational, educational discussions
- References specific historical facts in responses
- Gracefully handles situations when Ollama is not available

### 3. Learning Mechanism

The system automatically detects and saves new historical insights from user conversations:

- Monitors chat for user-shared historical information
- Identifies messages containing dates, locations, and personal stories
- Saves insights for later verification
- Links insights to specific cities and topics
- Builds knowledge base from community contributions

### 4. Beautiful Chat Interface

A modern, responsive chat UI featuring:

- Real-time chat with typing indicators
- Message history persistence
- Sidebar with clickable cities and topics
- Suggested questions to get started
- Statistics showing how many historical facts were referenced
- Mobile-responsive design

## Architecture

### Database Schema

**New Tables:**
- `historical_cities` - Cities and towns with founding information
- `historical_topics` - Categories of historical content
- `historical_periods` - Time periods for organizing history
- `historical_facts` - Individual historical events and facts
- `historical_people` - Notable people (ready for future expansion)
- `chat_conversations` - Chat session tracking
- `chat_messages` - Individual chat messages
- `learned_insights` - User-contributed historical information

### API Endpoints

**Historical Data:**
- `GET /api/history/cities` - List all cities
- `GET /api/history/cities/:id` - Get city with related facts
- `GET /api/history/topics` - List all topics
- `GET /api/history/periods` - List all time periods
- `GET /api/history/facts` - Get facts (supports filters: city_id, topic_id, search, year)
- `GET /api/history/facts/:id` - Get single fact
- `POST /api/history/facts` - Create new fact (for learning from chats)

**Chat:**
- `POST /api/history/chat/conversation` - Create or get conversation
- `GET /api/history/chat/conversation/:id/messages` - Get conversation messages
- `POST /api/history/chat/message` - Save chat message
- `POST /api/history/chat` - Chat with AI agent

**Insights:**
- `GET /api/history/insights` - Get learned insights (supports ?verified=true/false)
- `POST /api/history/insights` - Manually add insight

### Files Created

1. **`history-database.js`** - Database initialization and seeding
2. **`history-chat-agent.js`** - AI chat agent with Ollama integration
3. **`public/history.html`** - Chat interface frontend
4. **Updated `api-server.js`** - Added historical API endpoints
5. **Updated `public/index.html`** - Added History navigation link
6. **Updated `public/venues.html`** - Added History navigation link

## Usage

### Accessing the History Section

1. Navigate to `http://localhost:8081/history` (or your production URL)
2. Start chatting with the AI agent
3. Click on cities or topics in the sidebar for quick questions
4. Use suggested question chips to get started

### For Developers

**Initialize the database:**
```bash
node history-database.js
```

**Test the chat agent:**
```bash
# Make sure Ollama is running first
ollama serve

# In another terminal
node history-chat-agent.js
```

**Test API endpoints:**
```bash
# Get all cities
curl http://localhost:3001/api/history/cities

# Get facts about Beaumont (city_id=1)
curl "http://localhost:3001/api/history/facts?city_id=1"

# Search facts
curl "http://localhost:3001/api/history/facts?search=oil"

# Chat with agent
curl -X POST http://localhost:3001/api/history/chat \
  -H "Content-Type: application/json" \
  -d '{"message":"Tell me about Spindletop","conversation_id":1}'
```

## Ollama Setup (Required for Chat)

The chat agent requires Ollama to be running:

1. **Install Ollama:**
   ```bash
   # Visit https://ollama.com to download and install
   ```

2. **Pull a model:**
   ```bash
   ollama pull llama3.2
   ```

3. **Start Ollama server:**
   ```bash
   ollama serve
   ```

4. **Configure model (optional):**
   ```bash
   export OLLAMA_MODEL=llama3.2  # or another model
   export OLLAMA_URL=http://localhost:11434
   ```

**Note:** If Ollama is not running, the chat will display a friendly error message directing users to start it.

## Data Sources

Initial historical data sourced from:
- Texas State Historical Association (TSHA)
- Spindletop Museum
- Heritage House of Orange County
- City of Orange official records
- Port Arthur historical records

All facts are marked as verified and include source citations.

## Future Enhancements

Potential additions for the history feature:

1. **Historical Images**: Add images to facts and cities
2. **Timeline View**: Interactive timeline visualization
3. **Notable People**: Expand the historical_people table with biographies
4. **Primary Sources**: Link to historical documents and photos
5. **User Stories**: Allow users to submit family stories and memories
6. **Verification System**: Admin interface to review and verify learned insights
7. **Audio Guide**: Add text-to-speech for accessibility
8. **Historical Tours**: GPS-based walking tours of historical sites
9. **Educational Resources**: Lesson plans for local schools
10. **API for Researchers**: Public API for historians and researchers

## Learning from Users

The system automatically captures interesting historical insights when users share:

- Personal or family stories about the region
- Specific dates and events
- Information about local places and landmarks
- Cultural traditions and practices

These insights are saved to the `learned_insights` table and can be:
- Reviewed by administrators
- Verified against historical sources
- Promoted to official historical facts
- Used to improve the AI agent's knowledge

## Impact

This feature transforms SETX Events from a simple event aggregator into a comprehensive cultural platform where:

1. **Locals never have to wonder what to do** - They can discover events AND learn about their heritage
2. **Newcomers can learn** - New residents can quickly understand the region's rich history
3. **Students have resources** - Local students have an accessible learning tool
4. **Knowledge is preserved** - Community stories and memories are captured and saved
5. **Pride is fostered** - Residents can explore and celebrate their regional identity

## Technical Notes

- **Database**: SQLite with proper indexing for performance
- **AI Model**: Ollama (local, private, no API costs)
- **Frontend**: Vanilla JavaScript (no build step required)
- **Backend**: Express.js with RESTful API design
- **Security**: Parameterized queries prevent SQL injection
- **Scalability**: Can easily migrate to PostgreSQL if needed

## Metrics & Monitoring

Track the following to measure success:

- Number of chat conversations started
- Average messages per conversation
- Most asked about topics and cities
- Learned insights captured
- User engagement time
- Popular historical facts (via view counts - future feature)

## License

This historical content is educational and sourced from public historical records. All facts include source citations. User-contributed content is subject to verification before being promoted to official facts.

---

Built with ❤️ for Southeast Texas
