#!/bin/bash

# Disable root login with password authentication
sed -i 's/^PermitRootLogin.*/PermitRootLogin without-password/' /etc/ssh/sshd_config

# Allow only SSH key-based authentication
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# Restart the SSH service
systemctl restart ssh