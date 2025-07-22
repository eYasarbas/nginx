FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY certs       /etc/nginx/certs

VOLUME ["/var/log/nginx"]

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
