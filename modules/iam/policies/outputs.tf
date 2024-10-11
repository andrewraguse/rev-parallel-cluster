# Output for S3 read policy for post-install scripts
output "s3_post_install_bucket_read_policy" {
  value = aws_iam_policy.s3_post_install_bucket_read_policy.arn
  description = "Read policy that allows for read access of the post install script bucket"
}

# Output for EC2 describe policy
output "ec2_describe_policy" {
  value = aws_iam_policy.ec2_describe_policy.arn
  description = "EC2 describe policy"
}

# Output for CloudFormation policy
output "cloudformation_policy" {
  value = aws_iam_policy.cloudformation_policy.arn
  description = "Allows interaction with CloudFormation stacks"
}

# Output for AutoScaling policy
output "autoscaling_policy" {
  value = aws_iam_policy.autoscaling_policy.arn
  description = "Allow AutoScaling permissions"
}

# Output for PassRole policy
output "pass_role_policy" {
  value = aws_iam_policy.pass_role_policy.arn
  description = "Allow PassRole action"
}