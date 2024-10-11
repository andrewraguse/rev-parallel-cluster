variable "iam_user_names" {
  description = "List of IAM user names"
  type = list(object({
    user_name = string,
    type = string
  }))
}

variable "iam_access_keys" {
  description = "The access keys for all users"
  type = map(object({
    user_name = string  # IAM User name
    access_key_id = string  # Access Key ID
    secret_key = string  # Secret Key (optional to store in Secrets Manager)
  }))
  sensitive = true
}
