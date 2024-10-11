# IAM role for ParallelCluster EC2 instances
resource "aws_iam_role" "pcluster_ec2_role" {
  name               = "ParallelClusterEC2Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for PassRole action
resource "aws_iam_policy" "pass_role_policy" {
  name        = "PassRolePolicy"
  description = "Policy to allow EC2 to pass roles"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "iam:PassRole",
       Resource = [
          aws_iam_role.pcluster_ec2_role.arn, # EC2 Role
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ParallelClusterLambdaRole-*" # Lambda Role (dynamically targeting the lambda role)
        ]

      }
    ]
  })
}

# Policy to allow Lambda to pass the EC2 role
resource "aws_iam_policy" "lambda_pass_ec2_role_policy" {
  name        = "LambdaPassEC2RolePolicy"
  description = "Policy to allow Lambda to pass EC2 role to ParallelCluster instances"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "iam:PassRole",
        Resource = aws_iam_role.pcluster_ec2_role.arn  # The EC2 role ARN
      }
    ]
  })
}

# Attach the S3 read-only policy to the EC2 role
resource "aws_iam_role_policy_attachment" "s3_read_policy_attachment" {
  role       = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.post_install_scripts_read_bucket_policy
}

resource "aws_iam_role_policy_attachment" "ec2_describe_policy_attachment" {
  role       = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.ec2_describe_policy
}

resource "aws_iam_role_policy_attachment" "pass_role_policy_attachment" {
  role       = aws_iam_role.pcluster_ec2_role.name
  policy_arn = aws_iam_policy.pass_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloudformation_policy_attachment" {
  role       = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.cloudformation_policy
}

resource "aws_iam_role_policy_attachment" "autoscaling_policy_attachment" {
  role       = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.autoscaling_policy
}

# Attach the AmazonSSMManagedInstanceCore policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.pcluster_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}