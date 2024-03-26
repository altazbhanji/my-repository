#!/bin/bash

# update the OS
yum update -y

#install Apache
yum install httpd -y

# copy content to /var/www/html folder
cd /var/www/html
FOLDER="https://raw.githubusercontent.com/altazbhanji/my-repository/main/101-kittens-carousel-static-website-ec2/static-web"
wget ${FOLDER}/index.html
wget ${FOLDER}/cat0.jpg
wget ${FOLDER}/cat1.jpg
wget ${FOLDER}/cat2.jpg

# start and enable Apache service
systemctl start httpd
systemctl enable httpd


