resource "aws_sns_topic" "billing_alerts" {
  name = "billing-alerts"
}

resource "aws_sns_topic_subscription" "email_alerts" {
  for_each = toset(var.sns_alert_emails)

  topic_arn = aws_sns_topic.billing_alerts.arn
  protocol  = "email"
  endpoint  = each.value
}

module "billing_cloudwatch_alert" {
  source = "binbashar/cost-billing-alarm/aws"

  aws_env = coalesce(var.aws_profile, "default") # Use default profile if aws_profile is null
  aws_account_id = var.account_id
  monthly_billing_threshold = var.spending_alert_threshold
  currency = "USD"

  sns_topic_arns = [aws_sns_topic.billing_alerts.arn]
}