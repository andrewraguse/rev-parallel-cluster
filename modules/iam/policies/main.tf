# IAM policy that allows S3 read-only access
resource "aws_iam_policy" "s3_post_install_bucket_read_policy" {
  name        = "S3ReadOnlyAccessPolicy"
  description = "Policy to allow EC2 instances to read from S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:GetObject",
        Effect   = "Allow",
        Resource = "arn:aws:s3::${var.post_install_scripts_bucket_name}/*"  # Restrict to specific bucket
      }
    ]
  })
}

# IAM policy for EC2 describe actions
resource "aws_iam_policy" "ec2_describe_policy" {
  name        = "EC2DescribePolicy"
  description = "Policy to allow EC2 describe actions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeTags",
          "ec2:DescribeRegions",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeSecurityGroups"
        ],
        Resource = "*"
      }
    ]
  })
}

# IAM policy for CloudFormation actions
resource "aws_iam_policy" "cloudformation_policy" {
  name        = "CloudFormationPolicy"
  description = "Policy to allow EC2 instances to interact with CloudFormation"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "cloudformation:DescribeStacks",
          "cloudformation:ListStacks",
          "cloudformation:CreateStack",
          "cloudformation:UpdateStack",
          "cloudformation:DeleteStack"
        ],
        Resource = "*"
      }
    ]
  })
}

# IAM policy for AutoScaling actions
resource "aws_iam_policy" "autoscaling_policy" {
  name        = "AutoScalingPolicy"
  description = "Policy to allow EC2 instances to interact with AutoScaling"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:CreateAutoScalingGroup",
          "autoscaling:UpdateAutoScalingGroup",
          "autoscaling:DeleteAutoScalingGroup"
        ],
        Resource = "*"
      }
    ]
  })
}