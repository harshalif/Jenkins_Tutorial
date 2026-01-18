# Stage 1: Build React app
FROM node:22-alpine AS build
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install dependencies safely
RUN npm install --legacy-peer-deps

# Copy all project files
COPY . .

# Ensure environment is production
ENV NODE_ENV=production

# Build React app
RUN npm run build || { echo "Build failed"; exit 1; }

# Stage 2: Serve with Nginx
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*

# Copy build output
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
