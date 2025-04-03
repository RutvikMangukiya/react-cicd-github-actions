# Use Noe.js as the base iamge for building the app
FROM node:20 as build

# Set the work directory
WORKDIR /app

# Copy package.json and package-lock.json and install dependencies
COPY package.json .
RUN npm install

# Copy app files
COPY . .

# Build the react app
RUN npm run build

FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/dist .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

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