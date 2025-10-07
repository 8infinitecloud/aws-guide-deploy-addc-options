# AWS Configuration
aws_region = "us-east-1"

# Project Configuration
project_name = "github-actions-ad"
environment  = "dev"

# Active Directory Configuration
ad_type                = "ec2-ad"  # Options: managed-ad, simple-ad, connector-ad, ec2-ad
domain_name            = "example.local"
domain_admin_username  = "Administrator"
domain_admin_password  = "MySecurePassword123!"

# Client Configuration
client_count          = 1
windows_ami_id        = "ami-0c2b8ca1dad447f8a"  # Windows Server 2022
instance_type         = "t3.medium"
key_pair_name         = "github-actions-keypair"
root_volume_size      = 50
assign_elastic_ips    = false
