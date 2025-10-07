# VPN Gateway (if needed for on-premises connectivity)
resource "aws_vpn_gateway" "main" {
  count  = var.create_vpn_gateway ? 1 : 0
  vpc_id = data.terraform_remote_state.base.outputs.vpc_id

  tags = {
    Name = "${var.project_name}-vpn-gateway"
  }
}

# Customer Gateway
resource "aws_customer_gateway" "main" {
  count      = var.create_vpn_gateway ? 1 : 0
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = {
    Name = "${var.project_name}-customer-gateway"
  }
}

# VPN Connection
resource "aws_vpn_connection" "main" {
  count               = var.create_vpn_gateway ? 1 : 0
  vpn_gateway_id      = aws_vpn_gateway.main[0].id
  customer_gateway_id = aws_customer_gateway.main[0].id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "${var.project_name}-vpn-connection"
  }
}

# VPN Connection Route
resource "aws_vpn_connection_route" "on_premises" {
  count                  = var.create_vpn_gateway ? length(var.on_premises_cidrs) : 0
  vpn_connection_id      = aws_vpn_connection.main[0].id
  destination_cidr_block = var.on_premises_cidrs[count.index]
}
