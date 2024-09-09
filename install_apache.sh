#!/bin/bash

# Install Apache
sudo apt-get update
sudo apt-get install -y apache2

# Get token and pull instance id and public ipv4 from instance metadata
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
#INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id -H "X-aws-ec2-metadata-token: $TOKEN")                                           
INSTANCE_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4 -H "X-aws-ec2-metadata-token: $TOKEN")


sudo sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
sudo sed -i 's/:80>/:8080>/' /etc/apache2/sites-available/000-default.conf

sudo systemctl restart apache2


# echo to web page
echo "Hello World from SJSU-1! My public ip is: $INSTANCE_IP" > index.html

sudo cp index.html /var/www/html