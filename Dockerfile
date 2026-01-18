# Stage 1: Build React app
FROM node:22-alpine AS build
WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

# Install dependencies with legacy-peer-deps to avoid conflicts
RUN npm install --legacy-peer-deps

# Copy rest of the code
COPY . .

# Set environment variable for production build
ENV NODE_ENV=production

# Build React app
RUN npm run build || { echo "Build failed"; exit 1; }

# Stage 2: Serve with Nginx
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
