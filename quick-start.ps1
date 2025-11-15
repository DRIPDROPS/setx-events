# SETX Events - Windows One-Command Setup
# Run in PowerShell: iwr -useb https://raw.githubusercontent.com/DRIPDROPS/setx-events/claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8/quick-start.ps1 | iex

Write-Host "🚀 SETX Events - Automated Setup" -ForegroundColor Cyan
Write-Host ""

# Check if in repo
if (Test-Path ".git") {
    Write-Host "✅ Already in repo, pulling latest..." -ForegroundColor Green
    git pull origin claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8
} else {
    Write-Host "📥 Cloning repository..." -ForegroundColor Yellow
    git clone https://github.com/DRIPDROPS/setx-events.git
    Set-Location setx-events
    git checkout claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8
}

# Kill existing processes
Write-Host "🛑 Stopping existing services..." -ForegroundColor Yellow
Get-Process | Where-Object {$_.ProcessName -match "node|python"} | Where-Object {$_.CommandLine -match "api-server|8081"} | Stop-Process -Force -ErrorAction SilentlyContinue

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
npm install --silent

# Setup database
Write-Host "🗄️  Setting up database..." -ForegroundColor Yellow
node history-database.js

# Start API
Write-Host "🚀 Starting API server..." -ForegroundColor Yellow
Start-Process -NoNewWindow -FilePath "node" -ArgumentList "api-server.js"
Start-Sleep -Seconds 2

# Start frontend
Write-Host "🌐 Starting frontend..." -ForegroundColor Yellow
Set-Location public
Start-Process -NoNewWindow -FilePath "python" -ArgumentList "-m", "http.server", "8081"
Set-Location ..

Start-Sleep -Seconds 2

# Check if running
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3001/api/health" -UseBasicParsing -ErrorAction SilentlyContinue
    if ($response.StatusCode -eq 200) {
        Write-Host ""
        Write-Host "✅ DONE! Your site is running:" -ForegroundColor Green
        Write-Host ""
        Write-Host "   🌐 Open in browser: http://localhost:8081" -ForegroundColor Cyan
        Write-Host "   📅 Events: http://localhost:8081/index.html" -ForegroundColor White
        Write-Host "   🏛️  History: http://localhost:8081/history.html" -ForegroundColor White
        Write-Host "   📊 Dashboard: http://localhost:8081/dashboard.html" -ForegroundColor White
        Write-Host ""
        Write-Host "   API running at: http://localhost:3001" -ForegroundColor White
        Write-Host ""

        # Open browser
        Start-Process "http://localhost:8081"
    }
} catch {
    Write-Host "❌ Something went wrong. Check if ports 3001 or 8081 are in use." -ForegroundColor Red
}
