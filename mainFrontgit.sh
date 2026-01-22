#!/bin/bash
set -e
export HOME=/home/ubuntu

echo "✅ Connected via SSM (Frontend)!"

# Fix Git ownership warning
git config --global --add safe.directory /home/ubuntu/Projects/app-folder

cd /home/ubuntu/Projects/app-folder

# Pull latest code (use HTTPS if repo is private)
git pull origin main

# Install dependencies, ignoring post-install scripts
npm install --ignore-scripts

# Build the frontend
npm run build

# Reload or start PM2 process
pm2 reload "my-app"

echo "🚀 Frontend deployment completed successfully!"
