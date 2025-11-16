#!/bin/bash
# Deploy script for WSL - run this from your WSL terminal

echo "🏛️  Southeast Texas History - WSL Deployment"
echo "============================================"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop."
    echo "   Then run: wsl -d docker-desktop"
    exit 1
fi

echo "✅ Docker is running"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "📦 Installing GitHub CLI..."
    sudo apt-get update
    sudo apt-get install -y gh
fi

echo "✅ GitHub CLI ready"
echo ""

# Check if logged into GitHub
if ! gh auth status &> /dev/null; then
    echo "🔐 Please log in to GitHub:"
    gh auth login
fi

echo "✅ GitHub authenticated"
echo ""

# Create repo if it doesn't exist
echo "📁 Creating GitHub repository..."
gh repo create DRIPDROPS/setx-history --public --description "Southeast Texas History - AI-powered historical chat agent" 2>/dev/null || echo "   Repository already exists"

# Set remote and push
echo "📤 Pushing code..."
git remote remove origin 2>/dev/null
git remote add origin https://github.com/DRIPDROPS/setx-history.git
git push -u origin claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8

echo ""
echo "🚀 Starting application with Docker..."
docker-compose up -d --build

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📍 History app: http://localhost:3002"
echo ""
echo "Useful commands:"
echo "  docker-compose logs -f      # View logs"
echo "  docker-compose down         # Stop"
echo "  docker-compose restart      # Restart"
