# Output for IAM access keys
output "iam_access_keys" {
  value = module.iam_users.iam_access_keys  # Expose the output from the iam_users module
  description = "Access keys for all users to be used in the root module"
  sensitive = true  # Mark as sensitive to hide the access keys
}

# Output for IAM user names
output "iam_user_names" {
  value = module.iam_users.iam_user_names  # Expose the output from the iam_users module
  description = "iam user names for all users"
}

# Pass role policy for the headnode
output "pass_and_attach_role_policy" {
  value = module.iam_policies.pass_and_attach_role_policy
  description = "Pass role policy for the head node"
}

# Output for s3 post install read policy
output "s3_readonly_post_install_scripts_policy" {
  value = module.iam_policies.s3_readonly_post_install_scripts_policy
  description = "Allows s3 read post install script"
}