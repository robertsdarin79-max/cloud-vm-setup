# ☁️ Cloud Virtual Machine Setup — AWS EC2

> A hands-on portfolio project demonstrating how to launch, configure, and deploy a web application on a real cloud server from scratch.

![AWS](https://img.shields.io/badge/AWS-EC2-orange?style=flat-square&logo=amazon-aws)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04_LTS-E95420?style=flat-square&logo=ubuntu)
![Node.js](https://img.shields.io/badge/Node.js-20-339933?style=flat-square&logo=node.js)
![Nginx](https://img.shields.io/badge/Nginx-Reverse_Proxy-009639?style=flat-square&logo=nginx)
![PM2](https://img.shields.io/badge/PM2-Process_Manager-2B037A?style=flat-square)

---

## 🎯 Project Overview

This project walks through the complete lifecycle of setting up a cloud server — from launching an EC2 instance to serving a live Node.js application over the public internet. Everything is documented with real commands and configuration files.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **AWS EC2 (t2.micro)** | Cloud virtual machine |
| **Ubuntu 22.04 LTS** | Server operating system |
| **SSH + Key Pairs** | Secure remote access |
| **Nginx** | Web server / reverse proxy |
| **Node.js 20 + Express** | Application runtime & framework |
| **PM2** | Process manager (keeps app alive) |
| **AWS Security Groups** | Cloud-level firewall |
| **UFW** | OS-level firewall |

---

## 📁 Project Structure

```
cloud-vm-setup/
├── README.md               ← You are here
├── index.html              ← Project documentation page
├── app/
│   ├── server.js           ← Node.js Express application
│   └── package.json        ← Dependencies
├── nginx/
│   └── myapp.conf          ← Nginx reverse proxy config
└── scripts/
    ├── setup.sh            ← Server bootstrap automation
    └── deploy.sh           ← App deployment automation
```

---

## 🚀 Step-by-Step Setup

### Step 1 — Launch EC2 Instance
1. Go to **AWS Console → EC2 → Launch Instance**
2. Select **Ubuntu Server 22.04 LTS** (Free Tier)
3. Choose **t2.micro** instance type
4. Create a **key pair** → download `my-key.pem`
5. Configure security group: allow SSH (port 22)
6. Launch ✅

### Step 2 — Connect via SSH
```bash
chmod 400 my-key.pem
ssh -i "my-key.pem" ubuntu@<YOUR-PUBLIC-IP>
```

### Step 3 — Bootstrap the Server
```bash
# Upload and run the setup script
scp -i my-key.pem scripts/setup.sh ubuntu@<YOUR-IP>:~/
ssh -i my-key.pem ubuntu@<YOUR-IP> "bash setup.sh"
```

Or manually:
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install nginx -y
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs -y
sudo npm install -g pm2
```

### Step 4 — Deploy the App
```bash
# Copy app files to server
scp -i my-key.pem -r app/ ubuntu@<YOUR-IP>:~/myapp/

# SSH in and deploy
ssh -i my-key.pem ubuntu@<YOUR-IP>
cd ~/myapp && bash ~/deploy.sh
```

### Step 5 — Open Firewall Ports

**AWS Security Group (Inbound Rules):**

| Type | Protocol | Port | Source | Purpose |
|------|----------|------|--------|---------|
| SSH | TCP | 22 | My IP | Shell access |
| HTTP | TCP | 80 | 0.0.0.0/0 | Public web traffic |
| HTTPS | TCP | 443 | 0.0.0.0/0 | SSL (future) |

**UFW on the server:**
```bash
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw enable
sudo ufw status
```

---

## 🏗️ Architecture

```
Browser → Port 80 → [Nginx Reverse Proxy] → Port 3000 → [Node.js App]
                                                              ↕
                                                           [PM2]
                                                              ↕
                                                    [AWS EC2 · Ubuntu 22.04]
```

---

## 📚 Skills Demonstrated

- ✅ SSH key-pair authentication
- ✅ Linux server administration (Ubuntu)
- ✅ Nginx configuration & reverse proxying
- ✅ AWS Security Group firewall rules
- ✅ UFW OS-level firewall
- ✅ Process management with PM2
- ✅ Node.js + Express deployment
- ✅ Cloud infrastructure from scratch

---

## 📝 Notes

- This project uses the **AWS Free Tier** — t2.micro is free for 750 hours/month
- To add HTTPS, use **Certbot + Let's Encrypt** with a domain name
- PM2 ensures the app auto-restarts on crash or server reboot

---

*Part of my Cloud & DevOps portfolio — demonstrating real-world server skills.*
