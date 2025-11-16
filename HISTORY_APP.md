# Southeast Texas History App

Independent history chat application with AI historian.

## Location

`setx-events/setx-history/`

## Quick Start (Docker)

```bash
cd setx-history
docker-compose up -d
```

Visit http://localhost:3002

## Quick Start (Manual)

```bash
cd setx-history
npm install
./start.sh
```

## WSL Deployment

```bash
cd setx-history
./deploy-wsl.sh
```

This will:
- Check Docker
- Install GitHub CLI if needed
- Create DRIPDROPS/setx-history repository
- Push code
- Start containers

## Both Apps Running

**Events (port 3001):**
```bash
./restart-all.sh
```

**History (port 3002):**
```bash
cd setx-history && docker-compose up -d
```

Both apps are independent and can run simultaneously.
