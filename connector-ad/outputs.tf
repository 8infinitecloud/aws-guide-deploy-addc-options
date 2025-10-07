output "directory_id" {
  description = "ID of the AD Connector"
  value       = aws_directory_service_directory.connector.id
}

output "directory_name" {
  description = "Name of the directory"
  value       = aws_directory_service_directory.connector.name
}

output "dns_ip_addresses" {
  description = "DNS IP addresses of the connector"
  value       = aws_directory_service_directory.connector.dns_ip_addresses
}

output "security_group_id" {
  description = "Security group ID of the connector"
  value       = aws_directory_service_directory.connector.security_group_id
}

output "access_url" {
  description = "Access URL for the connector"
  value       = aws_directory_service_directory.connector.access_url
}

output "vpn_connection_id" {
  description = "ID of the VPN connection (if created)"
  value       = var.create_vpn_gateway ? aws_vpn_connection.main[0].id : null
}
