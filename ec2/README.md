# EC2 Module

Creates AWS EC2 instances with optional Elastic IP.

## Usage

```hcl
module "ec2" {
  source = "../../modules/ec2"

  instance_name     = "web-server"
  instance_type     = "t2.micro"
  subnet_id         = "subnet-12345"
  security_group_id = "sg-12345"
  key_name          = "my-key"
  environment       = "dev"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance_name | Name of EC2 instance | string | - | yes |
| instance_type | Instance type | string | "t2.micro" | no |
| ami_id | AMI ID (empty = latest Amazon Linux 2) | string | "" | no |
| subnet_id | Subnet ID | string | - | yes |
| security_group_id | Security Group ID | string | - | yes |
| key_name | SSH Key pair name | string | - | yes |
| monitoring_enabled | Enable detailed monitoring | bool | false | no |
| associate_public_ip | Associate public IP | bool | true | no |
| allocate_elastic_ip | Allocate Elastic IP | bool | false | no |
| environment | Environment name | string | - | yes |
| depends_on_resources | Resources to depend on | any | null | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | EC2 Instance ID |
| private_ip | Private IP address |
| public_ip | Public IP address |
| elastic_ip | Elastic IP (if allocated) |
| ssh_command | SSH connection command |

## Resources Created

- `aws_instance` - EC2 instance
- `aws_eip` - Elastic IP (optional)

## Example

```hcl
module "web_server" {
  source = "../../modules/ec2"

  instance_name           = "web-01"
  instance_type           = "t3.small"
  subnet_id               = module.vpc.public_subnet_id
  security_group_id       = module.sg_web.security_group_id
  key_name                = module.key_pair.key_pair_name
  allocate_elastic_ip     = true
  monitoring_enabled      = true
  environment             = "prod"
}

output "web_public_ip" {
  value = module.web_server.elastic_ip
}
```

## Instance Type Examples

- **Free Tier**: t2.micro (1GB RAM)
- **Small**: t3.small (2GB RAM)
- **Medium**: t3.medium (4GB RAM)
- **Large**: t3.large (8GB RAM)

## SSH Connection

After applying:

```bash
ssh -i path/to/key.pem ec2-user@PUBLIC_IP
```

Or use the provided output:

```bash
terraform output ssh_command
```
