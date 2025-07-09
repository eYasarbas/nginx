FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY certs      /etc/nginx/certs
# access ve error logları container içinde /var/log/nginx altında
VOLUME ["/var/log/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
