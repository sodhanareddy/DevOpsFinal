# Use the official Nginx image as the base image
FROM nginx:latest

# Copy your web pages to the Nginx document root
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

