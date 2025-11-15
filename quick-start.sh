#!/bin/bash
# SETX Events - One-Command Setup
# Just run: bash <(curl -s https://raw.githubusercontent.com/DRIPDROPS/setx-events/claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8/quick-start.sh)

set -e

echo "🚀 SETX Events - Automated Setup"
echo ""

# Check if we're in the repo already
if [ -d ".git" ]; then
    echo "✅ Already in repo, pulling latest..."
    git pull origin claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8
else
    echo "📥 Cloning repository..."
    git clone https://github.com/DRIPDROPS/setx-events.git
    cd setx-events
    git checkout claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8
fi

# Kill anything running on our ports
echo "🛑 Stopping existing services..."
pkill -f "node api-server" 2>/dev/null || true
pkill -f "python.*8081" 2>/dev/null || true

# Install dependencies
echo "📦 Installing dependencies..."
npm install --silent

# Setup database
echo "🗄️  Setting up database..."
node history-database.js

# Start API
echo "🚀 Starting API server..."
node api-server.js > /dev/null 2>&1 &
sleep 2

# Start frontend
echo "🌐 Starting frontend..."
cd public
python3 -m http.server 8081 > /dev/null 2>&1 &
cd ..

sleep 2

# Check if running
if curl -s http://localhost:3001/api/health > /dev/null; then
    echo ""
    echo "✅ DONE! Your site is running:"
    echo ""
    echo "   🌐 Open in browser: http://localhost:8081"
    echo "   📅 Events: http://localhost:8081/index.html"
    echo "   🏛️  History: http://localhost:8081/history.html"
    echo "   📊 Dashboard: http://localhost:8081/dashboard.html"
    echo ""
    echo "   API running at: http://localhost:3001"
    echo ""
    echo "To stop: pkill -f 'node api-server'; pkill -f 'python.*8081'"
else
    echo "❌ Something went wrong. Check if ports 3001 or 8081 are in use."
fi
