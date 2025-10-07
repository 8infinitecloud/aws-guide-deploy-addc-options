# Domain Controllers
resource "aws_instance" "domain_controller" {
  count                  = var.dc_count
  ami                    = var.windows_ami_id
  instance_type          = var.dc_instance_type
  key_name               = var.key_pair_name
  subnet_id              = data.terraform_remote_state.base.outputs.private_subnet_ids[count.index % length(data.terraform_remote_state.base.outputs.private_subnet_ids)]
  vpc_security_group_ids = [data.terraform_remote_state.base.outputs.ad_security_group_id]
  iam_instance_profile   = aws_iam_instance_profile.dc_profile.name

  root_block_device {
    volume_type = "gp3"
    volume_size = var.root_volume_size
    encrypted   = true
  }

  user_data = base64encode(templatefile("${path.module}/user_data.ps1", {
    domain_name         = var.domain_name
    domain_netbios_name = var.domain_netbios_name
    admin_password      = var.ad_admin_password
    safe_mode_password  = var.safe_mode_password
    is_first_dc         = count.index == 0
    first_dc_ip         = count.index == 0 ? "" : aws_instance.domain_controller[0].private_ip
    dc_number           = count.index + 1
  }))

  tags = {
    Name = "${var.project_name}-dc-${count.index + 1}"
    Role = "DomainController"
  }
}

# Elastic IPs for Domain Controllers (optional)
resource "aws_eip" "dc_eip" {
  count    = var.assign_elastic_ips ? var.dc_count : 0
  instance = aws_instance.domain_controller[count.index].id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-dc-${count.index + 1}-eip"
  }
}
