# Windows Domain Client
resource "aws_instance" "domain_client" {
  count                  = var.client_count
  ami                    = var.windows_ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair_name
  subnet_id              = data.terraform_remote_state.base.outputs.private_subnet_ids[count.index % length(data.terraform_remote_state.base.outputs.private_subnet_ids)]
  vpc_security_group_ids = [data.terraform_remote_state.base.outputs.ad_security_group_id, aws_security_group.client.id]
  iam_instance_profile   = aws_iam_instance_profile.client_profile.name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
    encrypted   = true
  }

  user_data = base64encode(templatefile("${path.module}/user_data.ps1", {
    domain_name    = var.domain_name
    admin_username = var.domain_admin_username
    admin_password = var.domain_admin_password
    dns_servers    = local.dns_servers
    client_name    = "${var.project_name}-client-${count.index + 1}"
  }))

  tags = {
    Name = "${var.project_name}-client-${count.index + 1}"
    Role = "DomainClient"
  }
}

# Elastic IPs for clients (optional)
resource "aws_eip" "client_eip" {
  count    = var.assign_elastic_ips ? var.client_count : 0
  instance = aws_instance.domain_client[count.index].id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-client-${count.index + 1}-eip"
  }
}
