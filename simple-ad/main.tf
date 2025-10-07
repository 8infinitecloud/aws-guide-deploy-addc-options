# Simple AD
resource "aws_directory_service_directory" "simple" {
  name       = var.domain_name
  password   = var.ad_admin_password
  size       = var.directory_size
  type       = "SimpleAD"
  short_name = var.domain_short_name

  vpc_settings {
    vpc_id     = data.terraform_remote_state.base.outputs.vpc_id
    subnet_ids = data.terraform_remote_state.base.outputs.private_subnet_ids
  }

  tags = {
    Name = "${var.project_name}-simple-ad"
  }
}
