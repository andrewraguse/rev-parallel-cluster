# Output for EC2 describe policy
output "ec2_describe_policy" {
  value = aws_iam_policy.ec2_describe_policy.arn
  description = "EC2 describe policy"
}

# Output for PassRole policy
output "pass_and_attach_role_policy" {
  value = aws_iam_policy.pass_and_attach_role_policy.arn
  description = "Allow PassRole action"
}

# Output for s3 post install read policy
output "s3_readonly_post_install_scripts_policy" {
  value = aws_iam_policy.s3_readonly_post_install_scripts_policy.arn
  description = "Allows s3 read post install script"
}