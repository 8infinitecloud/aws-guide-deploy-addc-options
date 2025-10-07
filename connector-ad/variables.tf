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
  description = "Domain name for on-premises Active Directory"
  type        = string
}

variable "connector_size" {
  description = "Size of the AD Connector (Small or Large)"
  type        = string
  default     = "Small"
  validation {
    condition     = contains(["Small", "Large"], var.connector_size)
    error_message = "Connector size must be either Small or Large."
  }
}

variable "service_account_username" {
  description = "Username for the service account in on-premises AD"
  type        = string
}

variable "service_account_password" {
  description = "Password for the service account in on-premises AD"
  type        = string
  sensitive   = true
}

variable "on_premises_dns_ips" {
  description = "DNS IP addresses of on-premises domain controllers"
  type        = list(string)
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

variable "create_vpn_gateway" {
  description = "Whether to create VPN gateway for on-premises connectivity"
  type        = bool
  default     = false
}

variable "customer_gateway_ip" {
  description = "Public IP address of the customer gateway"
  type        = string
  default     = ""
}

variable "customer_gateway_bgp_asn" {
  description = "BGP ASN of the customer gateway"
  type        = number
  default     = 65000
}

variable "on_premises_cidrs" {
  description = "CIDR blocks of on-premises networks"
  type        = list(string)
  default     = []
}
