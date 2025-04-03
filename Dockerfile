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

EXPOSE 5173

CMD [ "npm", "run", "dev"]

# Use NGINX as the base image  for serving the built app
#FROM nginx:alpine

#WORKDIR /var/www/html

#RUN rm -rf *

# Copy the built react app to the NGINX HTML directory
#COPY --from=build /app/dist .

# Expose port 80
#EXPOSE 80

# Start NGINX
#CMD [ "nginx",  "-g", "daemon off;" ]