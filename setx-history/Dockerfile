FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

# Initialize database on first run
RUN node history-database.js

EXPOSE 3002

CMD ["node", "api-server.js"]
