# Create an SNS topic for billing alerts
resource "aws_sns_topic" "billing_alerts" {
  name = "billing-alerts"
}

# Subscribe multiple email addresses to the billing alerts SNS topic
resource "aws_sns_topic_subscription" "email_alerts" {
  for_each = toset(var.sns_alert_emails) # Create one subscription per email in the list

  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol = "email"
  endpoint = each.value # Send alerts to the email specified by each element in var.sns_alert_emails
}

# Module to create a billing CloudWatch alarm based on monthly billing threshold
module "billing_cloudwatch_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  # AWS profile and account details
  aws_env = coalesce(var.aws_profile, "default") # Use default profile if aws_profile is null
  aws_account_id = var.account_id

  # Monthly billing alert threshold and currency settings
  monthly_billing_threshold = var.spending_alert_threshold
  currency = "USD"

  # Send notifications to the specified SNS topic when the billing threshold is exceeded
  sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
}

# Create CloudWatch alarm for actual current spending (not monthly, but ongoing accumulation)
resource "aws_cloudwatch_metric_alarm" "current_spending_alert" {
  alarm_name = "CurrentSpendingAlarm"
  comparison_operator = "GreaterThanThreshold" # Trigger when spending exceeds the threshold
  evaluation_periods = 1 # Number of periods to evaluate before triggering alarm
  metric_name = "EstimatedCharges" # AWS provided billing metric for estimated charges
  namespace = "AWS/Billing"
  period = 86400 # Check once per day (86400 seconds)
  statistic = "Maximum" # Use maximum value of estimated charges
  threshold = var.spending_alert_threshold # Set threshold for current spending
  unit = "None"

  # Alarm dimensions, filters by linked AWS account and currency (USD)
  dimensions = {
    Currency = "USD"
  }

  # Actions to take when alarm state changes to ALARM (send notification to SNS topic)
  alarm_actions = [aws_sns_topic.billing_alerts.arn]

  # Notify via SNS topic when the alarm returns to OK state
  ok_actions = [aws_sns_topic.billing_alerts.arn]

  # Notify via SNS topic if alarm becomes INSUFFICIENT_DATA (missing billing data)
  insufficient_data_actions = [aws_sns_topic.billing_alerts.arn]
}