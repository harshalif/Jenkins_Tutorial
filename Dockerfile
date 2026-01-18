# Stage 1: Build React + Vite app
FROM node:22-bullseye-slim AS build
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copy project files
COPY . .

# Set production environment
ENV NODE_ENV=production

# Debug Node version
RUN node -v
RUN npm run build || { echo "Build failed"; exit 1; }

# Stage 2: Serve with Nginx
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
