#!/bin/bash

# SSL sertifikalarını otomatik oluşturma scripti
# IP adresi: 217.18.209.111

echo "🔐 SSL sertifikaları oluşturuluyor..."

# Özel anahtar oluştur
echo "📝 Özel anahtar oluşturuluyor..."
openssl genrsa -out privkey.pem 4096

# CSR oluştur
echo "📋 Sertifika imzalama isteği oluşturuluyor..."
openssl req -new -key privkey.pem -out cert.csr -subj "/C=TR/ST=Istanbul/L=Istanbul/O=QRProject/OU=IT/CN=217.18.209.111"

# Self-signed sertifika oluştur
echo "🔒 Self-signed sertifika oluşturuluyor..."
openssl x509 -req -in cert.csr -signkey privkey.pem -out fullchain.pem -days 365

# Chain dosyası
echo "🔗 Chain dosyası oluşturuluyor..."
cp fullchain.pem chain.pem

# DH parametreleri
echo "🔐 Diffie-Hellman parametreleri oluşturuluyor..."
openssl dhparam -out dhparam.pem 2048

# OCSP stapling dosyası
echo "📄 OCSP stapling dosyası oluşturuluyor..."
touch stapling.ocsp

# Trusted certificate
echo "✅ Güvenilir sertifika oluşturuluyor..."
cp fullchain.pem trusted.crt

# Dosya izinlerini ayarla
echo "🔐 Dosya izinleri ayarlanıyor..."
chmod 600 privkey.pem
chmod 644 *.pem *.crt *.ocsp

# Geçici dosyaları temizle
echo "🧹 Geçici dosyalar temizleniyor..."
rm -f cert.csr

echo "✅ SSL sertifikaları başarıyla oluşturuldu!"
echo ""
echo "📁 Oluşturulan dosyalar:"
ls -la *.pem *.crt *.ocsp
echo ""
echo "⚠️  Not: Self-signed sertifika kullandığınız için tarayıcınız güvenlik uyarısı verecektir."
echo "   'Advanced' > 'Proceed to 217.18.209.111 (unsafe)' seçeneği ile devam edebilirsiniz." 