variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "domain_name" {
  description = "Domain name for Active Directory"
  type        = string
}

variable "domain_netbios_name" {
  description = "NetBIOS name for the domain"
  type        = string
}

variable "ad_admin_password" {
  description = "Active Directory administrator password"
  type        = string
  sensitive   = true
}

variable "safe_mode_password" {
  description = "Directory Services Restore Mode password"
  type        = string
  sensitive   = true
}

variable "dc_count" {
  description = "Number of domain controllers to deploy"
  type        = number
  default     = 2
  validation {
    condition     = var.dc_count >= 1 && var.dc_count <= 4
    error_message = "Domain controller count must be between 1 and 4."
  }
}

variable "windows_ami_id" {
  description = "AMI ID for Windows Server"
  type        = string
  default     = "ami-0c2b8ca1dad447f8a" # Windows Server 2022
}

variable "dc_instance_type" {
  description = "Instance type for domain controllers"
  type        = string
  default     = "t3.medium"
}

variable "key_pair_name" {
  description = "EC2 Key Pair name for domain controllers"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 50
}

variable "assign_elastic_ips" {
  description = "Whether to assign Elastic IPs to domain controllers"
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Number of days to retain CloudWatch logs"
  type        = number
  default     = 30
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for CloudWatch alarms"
  type        = string
  default     = ""
}
