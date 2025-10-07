# Security Group for Domain Clients
resource "aws_security_group" "client" {
  name_prefix = "${var.project_name}-client-"
  vpc_id      = data.terraform_remote_state.base.outputs.vpc_id

  # RDP from bastion
  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.base.outputs.bastion_security_group_id]
  }

  # WinRM for management
  ingress {
    from_port       = 5985
    to_port         = 5986
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.base.outputs.bastion_security_group_id]
  }

  # ICMP for ping
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [data.terraform_remote_state.base.outputs.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-client-sg"
  }
}
