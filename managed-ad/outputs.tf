output "directory_id" {
  description = "ID of the AWS Managed Microsoft AD"
  value       = aws_directory_service_directory.main.id
}

output "directory_name" {
  description = "Name of the directory"
  value       = aws_directory_service_directory.main.name
}

output "dns_ip_addresses" {
  description = "DNS IP addresses of the directory"
  value       = aws_directory_service_directory.main.dns_ip_addresses
}

output "security_group_id" {
  description = "Security group ID of the directory"
  value       = aws_directory_service_directory.main.security_group_id
}

output "access_url" {
  description = "Access URL for the directory"
  value       = aws_directory_service_directory.main.access_url
}
