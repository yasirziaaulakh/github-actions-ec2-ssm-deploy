#!/bin/bash
set -e  # stop on error

# Ensure HOME is set
export HOME=/home/ubuntu


sudo rm -rf /var/www/html/myapp/build/* || true
sudo mkdir -p /var/www/html/myapp/build
sudo cp -r /home/ubuntu/Builds/Main/FrontBuild/* /var/www/html/myapp/build
