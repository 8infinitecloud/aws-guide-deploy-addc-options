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

resource "aws_iam_role_policy_attachment" "ad_service" {
  role       = aws_iam_role.ad_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDirectoryServiceFullAccess"
}
