# SSL Sertifika Yapılandırması

Bu dizin SSL sertifikalarınızı içermelidir. Let's Encrypt kullanıyorsanız, aşağıdaki dosyaları buraya yerleştirin:

1. `cert.pem`: Domain sertifikanız
2. `chain.pem`: Let's Encrypt ara sertifikası (R3)
3. `root.pem`: ISRG Root X1 (kök sertifika)

Docker Compose başlatıldığında, bu dosyalar otomatik olarak birleştirilecek ve aşağıdaki dosyalar oluşturulacaktır:

- `fullchain.pem`: Domain sertifikanız + ara sertifika + kök sertifika
- `trusted.crt`: Kök sertifika

## Let's Encrypt ile Sertifika Alma

1. Certbot ile sertifika alın:
```bash
certbot certonly --standalone -d qr-admin.yourdomain.com -d qr-api.yourdomain.com
```

2. Sertifikaları bu dizine kopyalayın:
```bash
cp /etc/letsencrypt/live/qr-admin.yourdomain.com/cert.pem ./cert.pem
cp /etc/letsencrypt/live/qr-admin.yourdomain.com/chain.pem ./chain.pem
cp /etc/letsencrypt/live/qr-admin.yourdomain.com/root.pem ./root.pem
```

3. Dosya izinlerini ayarlayın:
```bash
chmod 644 *.pem *.crt
```

## Sertifika Zinciri Doğrulama

Sertifika zincirinizin doğru olduğunu kontrol etmek için:

```bash
openssl verify -CAfile trusted.crt fullchain.pem
```

## OCSP Stapling Doğrulama

OCSP stapling'in çalıştığını kontrol etmek için:

```bash
openssl s_client -connect qr-api.yourdomain.com:443 -status -servername qr-api.yourdomain.com
```

Çıktıda "OCSP Response Status: successful" görmelisiniz.

# SSL Sertifikaları Kurulumu

Bu dizin SSL sertifikalarınızı içermelidir. Domain adresiniz olmadığı için self-signed sertifika kullanabilirsiniz.

## Self-Signed Sertifika Oluşturma

### 1. Özel Anahtar Oluşturma
```bash
openssl genrsa -out privkey.pem 4096
```

### 2. Sertifika İmzalama İsteği (CSR) Oluşturma
```bash
openssl req -new -key privkey.pem -out cert.csr -subj "/C=TR/ST=Istanbul/L=Istanbul/O=QRProject/OU=IT/CN=217.18.209.111"
```

### 3. Self-Signed Sertifika Oluşturma
```bash
openssl x509 -req -in cert.csr -signkey privkey.pem -out fullchain.pem -days 365
```

### 4. Ara Sertifika Dosyası (Chain)
```bash
# Self-signed sertifika için chain dosyası aynı olacak
cp fullchain.pem chain.pem
```

### 5. Diffie-Hellman Parametreleri
```bash
openssl dhparam -out dhparam.pem 2048
```

### 6. OCSP Stapling Dosyası
```bash
# Self-signed sertifika için boş dosya
touch stapling.ocsp
```

### 7. Trusted Certificate
```bash
# Self-signed sertifika için aynı dosya
cp fullchain.pem trusted.crt
```

## Dosya İzinleri
```bash
chmod 600 privkey.pem
chmod 644 *.pem *.crt *.ocsp
```

## Gerekli Dosyalar
- `privkey.pem` - Özel anahtar
- `fullchain.pem` - Tam sertifika zinciri
- `chain.pem` - Ara sertifikalar
- `dhparam.pem` - Diffie-Hellman parametreleri
- `stapling.ocsp` - OCSP stapling dosyası
- `trusted.crt` - Güvenilir sertifika

## Not
Self-signed sertifika kullandığınız için tarayıcınız güvenlik uyarısı verecektir. Bu normal bir durumdur ve "Advanced" > "Proceed to 217.18.209.111 (unsafe)" seçeneği ile devam edebilirsiniz.

Production ortamında Let's Encrypt gibi ücretsiz SSL sertifika sağlayıcıları kullanmanızı öneririz. 