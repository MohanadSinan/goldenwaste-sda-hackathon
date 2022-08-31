public_ip=$(curl ipinfo.io/ip)
echo $public_ip

echo '
server {
    listen 80;

    server_name public_ip;

    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}' > goldenwaste

sed -i 's/public_ip/'${public_ip}'/g' goldenwaste
sudo cp goldenwaste /etc/nginx/sites-available/goldenwaste
ln -s /etc/nginx/sites-available/goldenwaste /etc/nginx/sites-enabled