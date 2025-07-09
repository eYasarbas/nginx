# Base image olarak Nginx'in resmi imajını kullan
FROM nginx:latest

# Sertifikalar ve config dosyasını ekleyelim
COPY nginx.conf /etc/nginx/nginx.conf
COPY certs /etc/nginx/certs/

# Portları expose edelim
EXPOSE 3000 8443

# Nginx başlat
CMD ["nginx", "-g", "daemon off;"]
