#! /bin/bash -x
dnf update -y
dnf install python3 -y
dnf install python-pip -y
pip3 install Flask==2.3.3
pip3 install Flask-MySql
pip3 install boto3
dnf install git -y
echo "${MyDBURI}" > /home/ec2-user/dbserver.endpoint
cd /home/ec2-user
git clone https://github.com/awsdevopsteam/phonebook-web-app.git
python3 /home/ec2-user/phonebook-web-app/phonebook-app.py
