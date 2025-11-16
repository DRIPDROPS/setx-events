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

# Expose ports
EXPOSE 3001 8081

# Start services
CMD ["./restart-all.sh"]
