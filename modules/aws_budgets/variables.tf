# Define the monthly spend limit to trigger alarms
variable "monthly_spend_limit" {
  type = string
  description = "Monthly spending limit to trigger alarms on."
}

# Define the list of emails to receive alarm notifications
variable "alert_emails" {
  type = list(string)
  description = "Emails to send alarm notifications to."
}
