FROM node:18-alpine

# Install Python for frontend server
RUN apk add --no-cache python3

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy application files
COPY . .

# Initialize database
RUN node history-database.js

# Expose ports
EXPOSE 3001 8081

# Create startup script
RUN echo '#!/bin/sh' > /app/start.sh && \
    echo 'node api-server.js &' >> /app/start.sh && \
    echo 'cd public && python3 -m http.server 8081' >> /app/start.sh && \
    chmod +x /app/start.sh

# Start services
CMD ["/app/start.sh"]
