# Simple EC2 Deployment

## Prerequisites
- AWS CLI configured
- Terraform installed
- SSH key generated

## Quick Start

### 1. Generate SSH Key
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
```

### 2. Configure AWS
```bash
aws configure
```

### 3. Deploy
```bash
cd terraform-aws-lab/ec2
terraform init
terraform apply
```

### 4. Connect
```bash
ssh -i ~/.ssh/id_rsa ec2-user@<public_ip>
```

## Cleanup
```bash
terraform destroy
```

## What Gets Created
- EC2 instance (Amazon Linux 2, t2.micro)
- Security Group (SSH access)
- SSH Key Pair
