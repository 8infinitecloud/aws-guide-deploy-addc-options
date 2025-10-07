# AD Connector
resource "aws_directory_service_directory" "connector" {
  name     = var.domain_name
  password = var.service_account_password
  size     = var.connector_size
  type     = "ADConnector"

  connect_settings {
    vpc_id            = data.terraform_remote_state.base.outputs.vpc_id
    subnet_ids        = data.terraform_remote_state.base.outputs.private_subnet_ids
    customer_dns_ips  = var.on_premises_dns_ips
    customer_username = var.service_account_username
  }

  tags = {
    Name = "${var.project_name}-ad-connector"
  }
}
