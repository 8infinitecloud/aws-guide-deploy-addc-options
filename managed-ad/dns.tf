# Route53 Records for AD
resource "aws_route53_record" "ad_dns" {
  count   = length(aws_directory_service_directory.main.dns_ip_addresses)
  zone_id = data.terraform_remote_state.base.outputs.route53_zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [aws_directory_service_directory.main.dns_ip_addresses[count.index]]
}
