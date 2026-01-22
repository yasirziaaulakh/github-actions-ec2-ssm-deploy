#!/bin/bash
set -e

echo "✅ Connected via SSM!"

# Run everything as ubuntu user
sudo -u ubuntu -H bash << 'EOF'

export HOME=/home/ubuntu
export PATH=$PATH:/usr/bin:/usr/local/bin

cd /home/ubuntu/Projects/Backend

git config --global --add safe.directory /home/ubuntu/Projects/Backend

git pull origin main

npm install

pm2 reload "my-app-backend"

EOF

echo "🚀 Deployment completed successfully!"
