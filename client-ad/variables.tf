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

variable "ad_type" {
  description = "Type of Active Directory (managed-ad, simple-ad, connector-ad, ec2-ad)"
  type        = string
  validation {
    condition     = contains(["managed-ad", "simple-ad", "connector-ad", "ec2-ad"], var.ad_type)
    error_message = "AD type must be one of: managed-ad, simple-ad, connector-ad, ec2-ad."
  }
}

variable "domain_name" {
  description = "Domain name to join"
  type        = string
}

variable "domain_admin_username" {
  description = "Domain administrator username for joining domain"
  type        = string
  default     = "Administrator"
}

variable "domain_admin_password" {
  description = "Domain administrator password for joining domain"
  type        = string
  sensitive   = true
}

variable "client_count" {
  description = "Number of domain clients to deploy"
  type        = number
  default     = 1
  validation {
    condition     = var.client_count >= 1 && var.client_count <= 10
    error_message = "Client count must be between 1 and 10."
  }
}

variable "windows_ami_id" {
  description = "AMI ID for Windows Server/Client"
  type        = string
  default     = "ami-0c2b8ca1dad447f8a" # Windows Server 2022
}

variable "instance_type" {
  description = "Instance type for domain clients"
  type        = string
  default     = "t3.medium"
}

variable "key_pair_name" {
  description = "EC2 Key Pair name for domain clients"
  type        = string
}

variable "root_volume_size" {
  description = "Size of the root volume in GB"
  type        = number
  default     = 50
}

variable "assign_elastic_ips" {
  description = "Whether to assign Elastic IPs to domain clients"
  type        = bool
  default     = false
}
