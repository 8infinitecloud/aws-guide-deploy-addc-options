# CloudWatch Log Group for Domain Controllers
resource "aws_cloudwatch_log_group" "dc_logs" {
  name              = "/aws/ec2/domain-controllers"
  retention_in_days = var.log_retention_days

  tags = {
    Name = "${var.project_name}-dc-logs"
  }
}

# CloudWatch Alarms for Domain Controllers
resource "aws_cloudwatch_metric_alarm" "dc_cpu_utilization" {
  count               = var.dc_count
  alarm_name          = "${var.project_name}-dc-${count.index + 1}-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors DC CPU utilization"
  alarm_actions       = var.sns_topic_arn != "" ? [var.sns_topic_arn] : []

  dimensions = {
    InstanceId = aws_instance.domain_controller[count.index].id
  }

  tags = {
    Name = "${var.project_name}-dc-${count.index + 1}-cpu-alarm"
  }
}
