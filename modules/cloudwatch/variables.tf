variable "account_id" {
    type = string
    description = "AWS account Id."
}

variable "aws_profile" {
    type = string
    description = "AWS profile"
}

variable "sns_alert_emails" {
    type = list(string)
    description = "Emails to send alarm notifications to"
}

variable "spending_alert_threshold" {
    type = number
    description = "Emails to send alarm notifications to"
}