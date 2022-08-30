#!/bin/bash
# Change the permissions of private SSH key
chmod 400 /home/ubuntu/GoldenWaste/.ssh/temp.pem
# Reload bash's .profile
. /etc/profile
# Setting Ansible environmental configuration
if test -z "$ANSIBLE_INVENTORY" 
then
      echo "export ANSIBLE_INVENTORY=$(echo /home/ubuntu/GoldenWaste/ansible/hosts/GoldenWasteHosts)" >> /etc/profile
      echo "\$ANSIBLE_INVENTORY is in your environment"
else
      echo "No need to set \$ANSIBLE_INVENTORY in your environment"
fi
if test -z "$ANSIBLE_HOST_KEY_CHECKING" 
then
      echo "export ANSIBLE_HOST_KEY_CHECKING=$(echo False)" >> /etc/profile
      echo "\$ANSIBLE_HOST_KEY_CHECKING is in your environment"
else
      echo "No need to set \$ANSIBLE_HOST_KEY_CHECKING is in your environment"
fi
# Configure AWS CLI with EC2DescribeInstancesReadOnly
if test -z "$AWS_ACCESS_KEY_ID" 
then
      echo "export AWS_ACCESS_KEY_ID=$(echo AKIAYI5ZPTNKZFCMDBXG)" >> /etc/profile
      echo "\$AWS_ACCESS_KEY_ID is in your environment"
else
      echo "No need to set \$AWS_ACCESS_KEY_ID is in your environment"
fi
if test -z "$AWS_SECRET_ACCESS_KEY" 
then
      echo "export AWS_SECRET_ACCESS_KEY=$(echo HrhifsUEKsNuVyyH/pUkJzqK6cpFzqGGneGWTwkv)" >> /etc/profile
      echo "\$AWS_SECRET_ACCESS_KEY is in your environment"
else
      echo "No need to set \$AWS_SECRET_ACCESS_KEY is in your environment"
fi
# Reload bash's .profile
. /etc/profile
# Setting EC2:PrivateIpAddress as an environment variables
if test -z "$WEB_PRIVATE_IP" 
then
      echo "export WEB_PRIVATE_IP=$(aws ec2 describe-instances --region us-east-1 --filters Name=tag:Name,Values=GoldenWasteWebApp --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)" >> /etc/profile
      echo "\$WEB_PRIVATE_IP is in your environment"
else
      echo "No need to set \$WEB_PRIVATE_IP is in your environment"
fi
if test -z "$DB_PRIVATE_IP" 
then
      echo "export DB_PRIVATE_IP=$(aws ec2 describe-instances --region us-east-1 --filters Name=tag:Name,Values=GoldenWasteDB --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)" >> /etc/profile
      echo "\$DB_PRIVATE_IP is in your environment"
else
      echo "No need to set \$DB_PRIVATE_IP is in your environment"
fi
# Reload bash's .profile
. /etc/profile
# Update the Ansible inventory file
echo -e "[GoldenWasteWebApp]\nWebApp ansible_user=ubuntu ansible_host=$WEB_PRIVATE_IP\n\n[GoldenWasteDB]\nDB ansible_user=ubuntu ansible_host=$DB_PRIVATE_IP\n\n[all:vars]\nansible_ssh_private_key_file=/home/ubuntu/GoldenWaste/.ssh/temp.pem" > /home/ubuntu/GoldenWaste/ansible/hosts/GoldenWasteHosts
echo "Ansible inventory file updated"
# Reload bash's .profile
. /etc/profile