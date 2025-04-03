# Use Noe.js as the base iamge for building the app
FROM node:20 as build

# Set the work directory
WORKDIR /app

# Copy package.json and package-lock.json and install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy app files
COPY . .

# Build the react app
RUN npm run build

# Use NGINX as the base image  for serving the built app
FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf /usr/share/nginx/html/*

# Copy the built react app to the NGINX HTML directory
COPY --from=build /app/node_modules .

# Expose port 80
EXPOSE 80

# Start NGINX
CMD [ "nginx",  "-g", "daemon off;" ]