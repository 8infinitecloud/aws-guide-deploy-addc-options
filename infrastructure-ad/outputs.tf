output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "ad_security_group_id" {
  description = "ID of the AD security group"
  value       = aws_security_group.ad.id
}

output "bastion_security_group_id" {
  description = "ID of the bastion security group"
  value       = aws_security_group.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "route53_zone_id" {
  description = "ID of the Route53 private hosted zone"
  value       = aws_route53_zone.private.zone_id
}

output "ad_service_role_arn" {
  description = "ARN of the AD service role"
  value       = aws_iam_role.ad_service.arn
}

output "ad_admin_secret_arn" {
  description = "ARN of the AD admin credentials secret"
  value       = aws_secretsmanager_secret.ad_admin.arn
}
