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

variable "domain_short_name" {
  description = "Short name for the domain"
  type        = string
}

variable "ad_admin_password" {
  description = "Active Directory administrator password"
  type        = string
  sensitive   = true
}

variable "ad_edition" {
  description = "Edition of AWS Managed Microsoft AD (Standard or Enterprise)"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Enterprise"], var.ad_edition)
    error_message = "AD edition must be either Standard or Enterprise."
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
