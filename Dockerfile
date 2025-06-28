FROM nginx:alpine

# Default konfigürasyonu kaldır
RUN rm -f /etc/nginx/conf.d/default.conf

# Bizim konfigürasyonumuzu kopyala
COPY nginx.conf /etc/nginx/nginx.conf

# CORS konfigürasyonunu kopyala
COPY conf.d/cors.conf /etc/nginx/conf.d/cors.conf

RUN mkdir -p /var/log/nginx \
 && chown -R nginx:nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
