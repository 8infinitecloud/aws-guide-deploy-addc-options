# Test EC2 instance for domain join validation (optional)
resource "aws_instance" "test_instance" {
  count                  = var.create_test_instance ? 1 : 0
  ami                    = var.test_instance_ami_id
  instance_type          = var.test_instance_type
  subnet_id              = data.terraform_remote_state.base.outputs.private_subnet_ids[0]
  vpc_security_group_ids = [data.terraform_remote_state.base.outputs.ad_security_group_id]
  key_name               = var.key_pair_name

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    domain_name     = var.domain_name
    admin_password  = var.ad_admin_password
    dns_ip_1        = aws_directory_service_directory.simple.dns_ip_addresses[0]
    dns_ip_2        = length(aws_directory_service_directory.simple.dns_ip_addresses) > 1 ? aws_directory_service_directory.simple.dns_ip_addresses[1] : aws_directory_service_directory.simple.dns_ip_addresses[0]
  }))

  tags = {
    Name = "${var.project_name}-test-instance"
  }
}
