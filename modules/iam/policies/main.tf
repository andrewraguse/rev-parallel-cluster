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

resource "aws_iam_policy" "s3_output_files_full_access_policy" {
  name        = "S3OutputFilesFullAccess"
  description = "Allows full access to a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketVersions"
        ]
        Resource = "arn:aws:s3:::${var.output_files_bucket_name}"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:DeleteObjectVersion",
          "s3:GetObjectVersion",
          "s3:PutObjectAcl",
          "s3:GetBucketAcl",
          "s3:PutBucketAcl"
        ]
        Resource = "arn:aws:s3:::${var.output_files_bucket_name}/*"
      }
    ]
  })
}


