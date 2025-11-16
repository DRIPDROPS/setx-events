#!/bin/bash
# Split history app into separate repository (optional)

echo "🔀 Splitting setx-history into separate repository..."
echo ""

cd ~/setx-events

# Check if setx-history exists
if [ ! -d "setx-history" ]; then
    echo "❌ setx-history directory not found"
    exit 1
fi

# Create separate directory
echo "📁 Creating ~/setx-history..."
mkdir -p ~/setx-history-separate
cp -r setx-history/* setx-history-separate/
cd ~/setx-history-separate

# Initialize git
echo "🔧 Initializing git repository..."
git init
git checkout -b claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8
git add .
git commit -m "Initial commit: Southeast Texas History application"

# Create GitHub repo
echo "📤 Creating GitHub repository..."
gh repo create DRIPDROPS/setx-history --public --description "Southeast Texas History - AI-powered historical chat agent" || echo "Repository may already exist"

# Push
echo "🚀 Pushing to GitHub..."
git remote add origin https://github.com/DRIPDROPS/setx-history.git
git push -u origin claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8

echo ""
echo "✅ Done!"
echo ""
echo "Separate repository: ~/setx-history-separate"
echo "GitHub: https://github.com/DRIPDROPS/setx-history"
echo ""
echo "You now have:"
echo "  ~/setx-events/setx-history     (auto-syncs via teleport)"
echo "  ~/setx-history-separate        (independent git repo)"
echo ""
echo "You can delete ~/setx-events/setx-history if you want,"
echo "or keep both and manually sync changes."
