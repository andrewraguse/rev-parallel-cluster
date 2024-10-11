# Output for IAM access keys
output "iam_access_keys" {
  value = {
    for key in aws_iam_access_key.user_access_keys : key.user => {
      user_name = key.user  # IAM User name associated with the access key
      access_key_id = key.id  # Access Key ID
      secret_key = key.secret  # Secret Key (optional to store in Secrets Manager)
    }
  }
  description = "Access keys for IAM users"
  sensitive   = true  # Mark as sensitive to hide access key IDs and secrets
}

# Output for IAM user names
output "iam_user_names" {
  value = var.iam_users
  description = "IAM user names"
}
