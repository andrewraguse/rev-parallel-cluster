output "iam_access_keys" {
  value = module.iam_users.iam_access_keys  # Expose the output from the iam_users module
  description = "Access keys for all users to be used in the root module"
  sensitive   = true  # Mark as sensitive to hide the access keys
}

output "iam_user_names" {
  value = module.iam_users.iam_user_names  # Expose the output from the iam_users module
  description = "iam user names for all users"
}