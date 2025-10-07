# IAM Role for AD Services
resource "aws_iam_role" "ad_service" {
  name = "${var.project_name}-ad-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ds.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-ad-service-role"
  }
}

resource "aws_iam_role_policy" "ad_service" {
  name = "${var.project_name}-ad-service-policy"
  role = aws_iam_role.ad_service.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ds:*",
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeSecurityGroups",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupEgress"
        ]
        Resource = "*"
      }
    ]
  })
}
