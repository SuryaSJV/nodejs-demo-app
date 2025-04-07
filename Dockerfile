# ---------- Stage 1: Build ----------
    FROM node:18 AS builder

    # Set working directory
    WORKDIR /app
    
    # Copy package files and install dependencies
    COPY package*.json ./
    RUN npm install
    
    # Copy the rest of the application
    COPY . .
    
    # ---------- Stage 2: Production ----------
    FROM node:18-slim
    
    # Set working directory
    WORKDIR /app
    
    # Copy only the necessary files from builder
    COPY --from=builder /app /app
    
    # Expose app port
    EXPOSE 5000
    
    # Start the app
    CMD ["node", "server.js"]
    