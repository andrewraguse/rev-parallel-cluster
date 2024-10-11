# AWS account ID variable
variable "account_id" {
  type = string
  description = "AWS account ID."
}

# AWS profile variable
variable "aws_profile" {
  type = string
  description = "AWS profile."
}

# List of emails to receive SNS alert notifications
variable "sns_alert_emails" {
  type = list(string)
  description = "Emails to send alarm notifications to."
}

# Spending alert threshold for cost alarms
variable "spending_alert_threshold" {
  type = number
  description = "Spending threshold to trigger alarms."
}