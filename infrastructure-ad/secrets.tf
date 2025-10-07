# Random string for unique secret naming
resource "random_string" "secret_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Secrets Manager for AD credentials
resource "aws_secretsmanager_secret" "ad_admin" {
  name        = "${var.project_name}-ad-admin-credentials-${random_string.secret_suffix.result}"
  description = "Active Directory administrator credentials"

  tags = {
    Name = "${var.project_name}-ad-admin-secret"
  }
}

resource "aws_secretsmanager_secret_version" "ad_admin" {
  secret_id = aws_secretsmanager_secret.ad_admin.id
  secret_string = jsonencode({
    username = var.ad_admin_username
    password = var.ad_admin_password
  })
}
