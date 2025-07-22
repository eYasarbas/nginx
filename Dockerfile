
FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

COPY certs /etc/nginx/certs

COPY --chown=nginx:nginx ../qr-admin/dist /usr/share/nginx/html

VOLUME ["/var/log/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
