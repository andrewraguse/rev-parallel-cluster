# AWS Budgets resource to create a cost-based budget
resource "aws_budgets_budget" "general_budget" {
  name = "general_budget"  # Name of the budget
  budget_type = "COST"  # Budget type (COST-based budget)
  limit_amount = var.monthly_spend_limit  # Monthly spending limit
  limit_unit = "USD"  # Currency unit
  time_unit = "MONTHLY"  # Time period for the budget

  notification {
    comparison_operator = "GREATER_THAN"  # Trigger notification when spending exceeds threshold
    threshold = 80  # Notify when spending reaches 80% of the budget
    threshold_type = "PERCENTAGE"  # The threshold is a percentage of the budget
    notification_type = "FORECASTED"  # Notification is triggered based on forecasted usage
    subscriber_email_addresses = var.alert_emails  # List of email addresses to receive the notification
  }

  tags = {
    Tag1 = "Rev Budget"  # Tag to identify the budget
  }
}
