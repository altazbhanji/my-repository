ip=$(grep PrivateIpAddress info.json | head -n1 | cut -d'"' -f4)
sed -i "s/ec2-private_ip/$ip/g" terraform.tf
