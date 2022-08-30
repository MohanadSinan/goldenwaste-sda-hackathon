#!/bin/bash
# Setting Ansible environmental configuration
if test -z "$ANSIBLE_INVENTORY" 
then
      echo "export ANSIBLE_INVENTORY=/home/ec2-user/GoldenWaste/ansible/hosts/GoldenWasteHosts" >> ~/.profile
      echo "\$ANSIBLE_INVENTORY is in your environment"
else
      echo "\$ANSIBLE_INVENTORY is in your environment"
fi
if test -z "$ANSIBLE_HOST_KEY_CHECKING" 
then
      echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> ~/.profile
      echo "\$ANSIBLE_HOST_KEY_CHECKING is in your environment"
else
      echo "\$ANSIBLE_HOST_KEY_CHECKING is in your environment"
fi
# Configure AWS CLI with EC2DescribeInstancesReadOnly
if test -z "$AWS_ACCESS_KEY_ID" 
then
      echo "export AWS_ACCESS_KEY_ID=AKIAYI5ZPTNKZFCMDBXG" >> ~/.profile
      echo "\$AWS_ACCESS_KEY_ID is in your environment"
else
      echo "\$AWS_ACCESS_KEY_ID is in your environment"
fi
if test -z "$AWS_SECRET_ACCESS_KEY" 
then
      echo "export AWS_SECRET_ACCESS_KEY=HrhifsUEKsNuVyyH/pUkJzqK6cpFzqGGneGWTwkv" >> ~/.profile
      echo "\$AWS_SECRET_ACCESS_KEY is in your environment"
else
      echo "\$AWS_SECRET_ACCESS_KEY is in your environment"
fi
# Setting EC2:PrivateIpAddress as an environment variables
if test -z "$WEB_PRIVATE_IP" 
then
      echo "export WEB_PRIVATE_IP=$(aws ec2 describe-instances --region us-east-1 --filters Name=tag:Name,Values=GoldenWasteWebApp --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)" >> ~/.profile
      echo "\$WEB_PRIVATE_IP is in your environment"
else
      echo "\$WEB_PRIVATE_IP is in your environment"
fi
if test -z "$DB_PRIVATE_IP" 
then
      echo "export DB_PRIVATE_IP=$(aws ec2 describe-instances --region us-east-1 --filters Name=tag:Name,Values=GoldenWasteDB --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text)" >> ~/.profile
      echo "\$DB_PRIVATE_IP is in your environment"
else
      echo "\$DB_PRIVATE_IP is in your environment"
fi
# Update the Ansible inventory file
echo -e "[GoldenWasteWebApp]\nWebApp ansible_user=ec2-user ansible_host=$WEB_PRIVATE_IP\n\n[GoldenWasteDB]\nDB ansible_user=ec2-user ansible_host=$DB_PRIVATE_IP\n\n[all:vars]\nansible_ssh_private_key_file=/home/ec2-user/GoldenWaste/.ssh/temp.pem" > /home/ec2-user/GoldenWaste/ansible/hosts/GoldenWasteHosts
echo "Ansible inventory file updated"