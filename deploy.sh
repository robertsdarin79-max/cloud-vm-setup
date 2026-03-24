#!/bin/bash
# deploy.sh — Deploy the Node.js app and configure Nginx
# Run from ~/myapp on the EC2 instance: bash deploy.sh

set -e

APP_DIR=~/myapp
NGINX_CONF=/etc/nginx/sites-available/myapp

echo "🚀 Deploying app..."

# Install dependencies
echo "📦 Installing npm packages..."
cd $APP_DIR
npm install --production

# Configure Nginx reverse proxy
echo "🌐 Configuring Nginx..."
sudo tee $NGINX_CONF > /dev/null <<EOF
server {
    listen 80;
    server_name _;

    gzip on;
    gzip_types text/plain application/json text/css application/javascript;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable site
sudo ln -sf $NGINX_CONF /etc/nginx/sites-enabled/myapp
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx

# Start / restart with PM2
echo "⚙️  Starting app with PM2..."
pm2 delete myapp 2>/dev/null || true
pm2 start server.js --name "myapp"
pm2 save
pm2 startup | tail -1 | sudo bash

echo "✅ Deployment complete!"
echo "   App:  http://$(curl -s http://checkip.amazonaws.com)"
echo "   PM2:  pm2 status"
echo "   Logs: pm2 logs myapp"
