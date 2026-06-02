# Use an official Node.js LTS image
FROM node:20-alpine

# Create app directory inside the container
WORKDIR /app

# Copy package files first (for better layer caching)
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the rest of your app
COPY . .

# Expose the port your app runs on (change if needed)
# EXPOSE 3000

# Start the app
CMD ["node", "server.js"]

