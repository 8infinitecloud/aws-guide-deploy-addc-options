# Route53 Records for Domain Controllers
resource "aws_route53_record" "dc_a_records" {
  count   = var.dc_count
  zone_id = data.terraform_remote_state.base.outputs.route53_zone_id
  name    = "dc${count.index + 1}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.domain_controller[count.index].private_ip]
}

resource "aws_route53_record" "domain_a_records" {
  count   = var.dc_count
  zone_id = data.terraform_remote_state.base.outputs.route53_zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [aws_instance.domain_controller[count.index].private_ip]
}
