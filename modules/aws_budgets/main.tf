resource "aws_budgets_budget" "general_budget" {
  name              = "general_budget"
  budget_type       = "COST"
  limit_amount      = var.monthly_spend_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.alert_emails
  }

  tags = {
    Tag1 = "Rev Budget"
  }
}