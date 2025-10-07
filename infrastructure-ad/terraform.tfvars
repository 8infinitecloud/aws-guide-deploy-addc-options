# AWS Configuration
aws_region = "us-east-1"

# Project Configuration
project_name = "github-actions-ad"
environment  = "dev"

# Network Configuration
vpc_cidr               = "10.0.0.0/16"
availability_zones     = ["us-east-1a", "us-east-1b"]
private_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnet_cidrs    = ["10.0.101.0/24", "10.0.102.0/24"]
allowed_cidr_blocks    = ["0.0.0.0/0"]

# Bastion Host Configuration
bastion_ami_id         = "ami-0c02fb55956c7d316"  # Amazon Linux 2
bastion_instance_type  = "t3.micro"
key_pair_name          = ""  # Leave empty if no key pair available

# Active Directory Configuration
domain_name        = "example.local"
ad_admin_username  = "Admin"
ad_admin_password  = "MySecurePassword123!"
