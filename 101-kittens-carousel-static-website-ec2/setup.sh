#! /bin/bash

 yum update -y
 yum install httpd -y

cd /var/www/html

FOLDER=https://raw.githubusercontent.com/altazbhanji/my-repository/main/101-kittens-carousel-static-website-ec2/static-web
wget ${FOLDER}/index.html
wget ${FOLDER}/cat0.jpg
wget ${FOLDER}/cat1.jpg
wget ${FOLDER}/cat2.jpg

systemctl start httpd
systemctl enable httpd
