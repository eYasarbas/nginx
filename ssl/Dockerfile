FROM alpine:latest

# Install OpenSSL
RUN apk add --no-cache openssl

# Create working directory
WORKDIR /certs

# Generate DH parameters
RUN openssl dhparam -out dhparam.pem 2048

# Generate private key
RUN openssl genrsa -out privkey.pem 2048

# Generate CSR with correct IP
RUN openssl req -new -key privkey.pem -out cert.csr -subj "/C=TR/ST=Istanbul/L=Istanbul/O=QRProject/OU=IT/CN=217.18.209.111"

# Generate self-signed certificate
RUN openssl x509 -req -days 365 -in cert.csr -signkey privkey.pem -out cert.pem

# Generate root certificate
RUN openssl req -x509 -newkey rsa:2048 -keyout root.key -out root.pem -days 365 -nodes -subj "/CN=RootCA"

# Create chain file
RUN cat cert.pem root.pem > chain.pem

# Create fullchain file
RUN cat cert.pem chain.pem > fullchain.pem

# Create OCSP stapling file
RUN touch stapling.ocsp

# Copy all certificates to the mounted volume
CMD ["sh", "-c", "cp /certs/*.pem /ssl/ && cp /certs/stapling.ocsp /ssl/ && chmod 644 /ssl/*"] 