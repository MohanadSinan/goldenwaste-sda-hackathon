#!/bin/bash
# Reload bash's .profile
. /etc/profile
# Update the Ansible inventory file
echo -e "[GoldenWasteWebApp]\nWebApp ansible_user=ubuntu ansible_host=$WEB_PRIVATE_IP\n\n[GoldenWasteDB]\nDB ansible_user=ubuntu ansible_host=$DB_PRIVATE_IP\n\n[all:vars]\nansible_ssh_private_key_file=/home/ubuntu/GoldenWaste/.ssh/temp.pem" > /home/ubuntu/GoldenWaste/ansible/hosts/GoldenWasteHosts
echo "Ansible inventory file updated"
# Update the default.conf file
echo -e 'server {\n    listen 80;\n\n    server_name $WEB_PUBLIC_IP ;\n\n    location / {\n        proxy_pass http://localhost:8080;\n        proxy_http_version 1.1;\n        proxy_set_header Upgrade $http_upgrade;\n        proxy_set_header Connection 'upgrade';\n        proxy_set_header Host $host;\n        proxy_cache_bypass $http_upgrade;\n    }\n}' > /home/ubuntu/GoldenWaste/ansible/playbooks/roles/nginx/templates/default.conf
echo "default.conf file updated"
# Reload bash's .profile
. /etc/profile