#!/bin/bash
# setup.sh — Bootstrap script for AWS EC2 Ubuntu 22.04
# Run this after connecting via SSH: bash setup.sh

set -e

echo "🚀 Starting server setup..."

# Update system
echo "📦 Updating packages..."
sudo apt update && sudo apt upgrade -y

# Install Nginx
echo "🌐 Installing Nginx..."
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Install Node.js 20
echo "🟢 Installing Node.js 20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs -y

# Install PM2
echo "⚙️  Installing PM2..."
sudo npm install -g pm2

# Configure UFW firewall
echo "🛡️  Configuring UFW firewall..."
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

# Create app directory
echo "📁 Creating app directory..."
mkdir -p ~/myapp

echo "✅ Server setup complete!"
echo "   Node: $(node -v)"
echo "   Nginx: $(nginx -v 2>&1)"
echo "   PM2:   $(pm2 -v)"
echo ""
echo "Next: Copy your app files to ~/myapp and run: bash deploy.sh"
