# IAM policy for EC2 describe actions
resource "aws_iam_policy" "ec2_describe_policy" {
  name = "EC2DescribePolicy"
  description = "Policy to allow EC2 describe actions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
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

# IAM policy for PassRole and AttachRolePolicy actions across all resources
resource "aws_iam_policy" "pass_and_attach_role_policy" {
  name        = "PassAndAttachRolePolicy"
  description = "Policy to allow passing and attaching policies to all roles"

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: [
          "iam:PassRole",
          "iam:AttachRolePolicy"
        ],
        Resource: "*"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_readonly_post_install_scripts_policy" {
  name        = "S3ReadOnlyPostInstallScriptsPolicy"
  description = "Read-only access to objects in the post-install scripts S3 bucket."

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect: "Allow",
        Action: [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource: [
          "arn:aws:s3:::${var.post_install_scripts_bucket_name}",
          "arn:aws:s3:::${var.post_install_scripts_bucket_name}/*"
        ]
      }
    ]
  })
}

