#!/bin/bash

sudo apt get update
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h1> terraform in one shot by rutvik patel </h1>" | sudo tee /var/www/html/index.html