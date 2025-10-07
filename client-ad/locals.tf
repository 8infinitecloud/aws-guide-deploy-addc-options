# Local values for DNS servers based on AD type
locals {
  dns_servers = var.ad_type == "ec2-ad" ? 
    try(data.terraform_remote_state.ad.outputs.domain_controller_private_ips, []) :
    try(data.terraform_remote_state.ad.outputs.dns_ip_addresses, [])
}
