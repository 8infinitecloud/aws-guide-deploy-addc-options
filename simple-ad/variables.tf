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
  description = "Domain name for Simple AD"
  type        = string
}

variable "domain_short_name" {
  description = "Short name for the domain"
  type        = string
}

variable "ad_admin_password" {
  description = "Simple AD administrator password"
  type        = string
  sensitive   = true
}

variable "directory_size" {
  description = "Size of the Simple AD (Small or Large)"
  type        = string
  default     = "Small"
  validation {
    condition     = contains(["Small", "Large"], var.directory_size)
    error_message = "Directory size must be either Small or Large."
  }
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

variable "create_test_instance" {
  description = "Whether to create a test instance for domain join validation"
  type        = bool
  default     = false
}

variable "test_instance_ami_id" {
  description = "AMI ID for test instance"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2
}

variable "test_instance_type" {
  description = "Instance type for test instance"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "EC2 Key Pair name for test instance"
  type        = string
  default     = ""
}
