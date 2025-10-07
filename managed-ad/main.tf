# AWS Managed Microsoft AD
resource "aws_directory_service_directory" "main" {
  name       = var.domain_name
  password   = var.ad_admin_password
  edition    = var.ad_edition
  type       = "MicrosoftAD"
  short_name = var.domain_short_name

  vpc_settings {
    vpc_id     = data.terraform_remote_state.base.outputs.vpc_id
    subnet_ids = data.terraform_remote_state.base.outputs.private_subnet_ids
  }

  tags = {
    Name = "${var.project_name}-managed-ad"
  }
}
