# EC2 Module - main.tf
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "main" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
    
    tags = {
      Name = "${var.instance_name}-root-volume"
    }
  }

  monitoring              = var.monitoring_enabled
  associate_public_ip_address = var.associate_public_ip

  tags = {
    Name        = var.instance_name
    Environment = var.environment
  }

  depends_on = [var.depends_on_resources]
}

# Optional: Elastic IP for static public IP
resource "aws_eip" "main" {
  count    = var.allocate_elastic_ip ? 1 : 0
  instance = aws_instance.main.id
  domain   = "vpc"

  tags = {
    Name        = "${var.instance_name}-eip"
    Environment = var.environment
  }

  depends_on = [aws_instance.main]
}
