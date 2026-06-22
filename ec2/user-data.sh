#!/bin/bash
# Update system packages
yum update -y

# Install basic utilities
yum install -y wget curl vim git

# Install Docker (optional)
# amazon-linux-extras install docker -y
# systemctl start docker
# systemctl enable docker
# usermod -a -G docker ec2-user

# Create a simple welcome page
cat > /tmp/instance-info.txt <<EOF
Instance initialized successfully!
Hostname: $(hostname)
IP Address: $(hostname -I)
EOF

echo "EC2 instance setup completed"
