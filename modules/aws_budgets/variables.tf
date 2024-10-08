variable "monthly_spend_limit" {
    type = string
    description = "Monthly spending limit to trigger alarms on."
}

variable "alert_emails" {
    type = list(string)
    description = "Emails to send alarm notifications to"
}