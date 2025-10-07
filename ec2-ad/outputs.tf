output "domain_controller_ids" {
  description = "IDs of the domain controller instances"
  value       = aws_instance.domain_controller[*].id
}

output "domain_controller_private_ips" {
  description = "Private IP addresses of domain controllers"
  value       = aws_instance.domain_controller[*].private_ip
}

output "domain_controller_public_ips" {
  description = "Public IP addresses of domain controllers (if Elastic IPs assigned)"
  value       = var.assign_elastic_ips ? aws_eip.dc_eip[*].public_ip : []
}

output "domain_name" {
  description = "Domain name"
  value       = var.domain_name
}

output "domain_netbios_name" {
  description = "NetBIOS domain name"
  value       = var.domain_netbios_name
}

output "backup_vault_arn" {
  description = "ARN of the backup vault"
  value       = aws_backup_vault.dc_backup_vault.arn
}

output "backup_plan_arn" {
  description = "ARN of the backup plan"
  value       = aws_backup_plan.dc_backup_plan.arn
}
