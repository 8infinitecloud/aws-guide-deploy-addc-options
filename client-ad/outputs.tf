output "client_instance_ids" {
  description = "IDs of the domain client instances"
  value       = aws_instance.domain_client[*].id
}

output "client_private_ips" {
  description = "Private IP addresses of domain clients"
  value       = aws_instance.domain_client[*].private_ip
}

output "client_public_ips" {
  description = "Public IP addresses of domain clients (if Elastic IPs assigned)"
  value       = var.assign_elastic_ips ? aws_eip.client_eip[*].public_ip : []
}

output "client_names" {
  description = "Names of the domain client instances"
  value       = [for i in range(var.client_count) : "${var.project_name}-client-${i + 1}"]
}

output "security_group_id" {
  description = "Security group ID for domain clients"
  value       = aws_security_group.client.id
}
