# Nginx image
FROM nginx:alpine

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/ /etc/nginx/conf.d/

# Create directories
RUN mkdir -p /var/log/nginx /etc/nginx/ssl /usr/share/nginx/html

EXPOSE 80 443

# Nginx'i başlat
CMD ["nginx", "-g", "daemon off;"] 