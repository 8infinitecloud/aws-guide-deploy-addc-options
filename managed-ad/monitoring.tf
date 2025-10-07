# CloudWatch Log Group for AD
resource "aws_cloudwatch_log_group" "ad_logs" {
  name              = "/aws/directoryservice/${aws_directory_service_directory.main.id}"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.project_name}-ad-logs"
  }
}

# CloudWatch Alarms
resource "aws_cloudwatch_metric_alarm" "ad_health" {
  alarm_name          = "${var.project_name}-ad-health"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "DirectoryServiceHealth"
  namespace           = "AWS/DirectoryService"
  period              = "300"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors AD health"
  alarm_actions       = var.sns_topic_arn != "" ? [var.sns_topic_arn] : []

  dimensions = {
    DirectoryId = aws_directory_service_directory.main.id
  }

  tags = {
    Name = "${var.project_name}-ad-health-alarm"
  }
}
