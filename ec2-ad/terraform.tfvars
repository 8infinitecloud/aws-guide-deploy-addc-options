# AWS Configuration
aws_region = "us-east-1"
terraform_bucket = "your-terraform-state-bucket"

# Project Configuration
project_name = "github-actions-ad"
environment  = "dev"

# Active Directory Configuration
domain_name         = "example.local"
domain_netbios_name = "EXAMPLE"
ad_admin_password   = "MySecurePassword123!"
safe_mode_password  = "MySecureSafeModePassword123!"

# Domain Controller Configuration
dc_count              = 2
windows_ami_id        = "ami-0c2b8ca1dad447f8a"  # Windows Server 2022
dc_instance_type      = "t3.medium"
key_pair_name         = "github-actions-keypair"
root_volume_size      = 50
assign_elastic_ips    = false

# Monitoring Configuration
log_retention_days = 30
sns_topic_arn      = ""  # Optional: SNS topic for alarms
