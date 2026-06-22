# EC2 Module - variables.tf
variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID (if empty, uses latest Amazon Linux 2)"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "monitoring_enabled" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}

variable "associate_public_ip" {
  description = "Associate a public IP address"
  type        = bool
  default     = true
}

variable "allocate_elastic_ip" {
  description = "Allocate Elastic IP"
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "depends_on_resources" {
  description = "Resources to depend on"
  type        = any
  default     = null
}
