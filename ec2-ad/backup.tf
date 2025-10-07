# KMS Key for Backup Encryption
resource "aws_kms_key" "backup_key" {
  description             = "KMS key for DC backups"
  deletion_window_in_days = 7

  tags = {
    Name = "${var.project_name}-backup-key"
  }
}

resource "aws_kms_alias" "backup_key" {
  name          = "alias/${var.project_name}-backup-key"
  target_key_id = aws_kms_key.backup_key.key_id
}

# AWS Backup Vault
resource "aws_backup_vault" "dc_backup_vault" {
  name        = "${var.project_name}-dc-backup-vault"
  kms_key_arn = aws_kms_key.backup_key.arn

  tags = {
    Name = "${var.project_name}-dc-backup-vault"
  }
}

# AWS Backup Plan
resource "aws_backup_plan" "dc_backup_plan" {
  name = "${var.project_name}-dc-backup-plan"

  rule {
    rule_name         = "daily_backup"
    target_vault_name = aws_backup_vault.dc_backup_vault.name
    schedule          = "cron(0 2 * * ? *)"

    lifecycle {
      cold_storage_after = 30
      delete_after       = 90  # Reduced from 365 for demo
    }

    recovery_point_tags = {
      Environment = var.environment
      BackupType  = "Daily"
    }
  }

  tags = {
    Name = "${var.project_name}-dc-backup-plan"
  }
}

# AWS Backup Selection
resource "aws_backup_selection" "dc_backup_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "${var.project_name}-dc-backup-selection"
  plan_id      = aws_backup_plan.dc_backup_plan.id

  resources = aws_instance.domain_controller[*].arn
}
