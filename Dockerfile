FROM nginx:alpine

# Default konfigürasyonu kaldır
RUN rm -f /etc/nginx/conf.d/default.conf

# Bizim konfigürasyonumuzu kopyala
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/log/nginx \
 && chown -R nginx:nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
