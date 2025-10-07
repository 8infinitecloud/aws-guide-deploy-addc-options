output "directory_id" {
  description = "ID of the Simple AD"
  value       = aws_directory_service_directory.simple.id
}

output "directory_name" {
  description = "Name of the directory"
  value       = aws_directory_service_directory.simple.name
}

output "dns_ip_addresses" {
  description = "DNS IP addresses of the directory"
  value       = aws_directory_service_directory.simple.dns_ip_addresses
}

output "security_group_id" {
  description = "Security group ID of the directory"
  value       = aws_directory_service_directory.simple.security_group_id
}

output "access_url" {
  description = "Access URL for the directory"
  value       = aws_directory_service_directory.simple.access_url
}

output "test_instance_id" {
  description = "ID of the test instance (if created)"
  value       = var.create_test_instance ? aws_instance.test_instance[0].id : null
}
