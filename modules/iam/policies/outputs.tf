output "s3_post_install_bucket_read_policy" {
    value = aws_iam_policy.s3_post_install_bucket_read_policy.arn
    description = "Read policy that allows for read access of the post install script bucket"
}

output "ec2_describe_policy" {
    value = aws_iam_policy.ec2_describe_policy.arn
    description = "EC2 describe policy"
}

output "cloudformation_policy" {
    value = aws_iam_policy.cloudformation_policy.arn
    description = "Allows interaction with cloudformation stacks"
}

output "autoscaling_policy" {
    value = aws_iam_policy.autoscaling_policy.arn
    description = "Allow autoscaling permissions"
}