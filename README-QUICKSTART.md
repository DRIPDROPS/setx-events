# SETX Events - Quick Start

## One Command Install

Copy and paste ONE command into your terminal:

### Linux / Mac / WSL:
```bash
bash <(curl -s https://raw.githubusercontent.com/DRIPDROPS/setx-events/claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8/quick-start.sh)
```

### Windows PowerShell:
```powershell
iwr -useb https://raw.githubusercontent.com/DRIPDROPS/setx-events/claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8/quick-start.ps1 | iex
```

That's it. Your browser will open automatically to http://localhost:8081

---

## What You Get

✅ Events aggregator for Southeast Texas
✅ Venue directory with 100+ venues
✅ AI-powered history chat agent
✅ Interactive dashboard
✅ Automatic event scraping

---

## Already Have It?

Just run it again - the script updates and restarts everything.

---

## Manual Setup (if you want control)

```bash
# Clone
git clone https://github.com/DRIPDROPS/setx-events.git
cd setx-events
git checkout claude/southeast-texas-work-01QuZJGw5iAhFf7RCURFGMD8

# Install
npm install
node history-database.js

# Run
node api-server.js &
cd public && python3 -m http.server 8081
```

Open http://localhost:8081

---

## Stop Everything

```bash
pkill -f "node api-server"
pkill -f "python.*8081"
```

---

## Need Help?

The site runs on:
- API: http://localhost:3001
- Frontend: http://localhost:8081

If ports are busy, something else is using them. Stop those processes first.
