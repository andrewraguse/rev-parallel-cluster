# IAM role for ParallelCluster EC2 instances
resource "aws_iam_role" "pcluster_ec2_role" {
  name = "ParallelClusterEC2Role"
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

# Attach the S3 read-only policy to the EC2 role
resource "aws_iam_role_policy_attachment" "s3_read_policy_attachment" {
  role = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.post_install_scripts_read_bucket_policy
}

# Attach the EC2 Describe Instances policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_describe_policy_attachment" {
  role = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.ec2_describe_policy
}

# Attach the PassRole policy to the EC2 role
resource "aws_iam_role_policy_attachment" "pass_role_policy_attachment_ec2" {
  role = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.pass_role_policy
}

resource "aws_iam_role_policy_attachment" "pass_role_policy_attachment_lambda" {
  role       = data.external.lambda_role_name.result["role_name"]
  policy_arn = var.pass_role_policy
}

# Attach the CloudFormation policy to allow interaction with CloudFormation stacks
resource "aws_iam_role_policy_attachment" "cloudformation_policy_attachment" {
  role = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.cloudformation_policy
}

# Attach the Autoscaling policy to allow EC2 instances to manage autoscaling groups
resource "aws_iam_role_policy_attachment" "autoscaling_policy_attachment" {
  role = aws_iam_role.pcluster_ec2_role.name
  policy_arn = var.autoscaling_policy
}

# Attach the Amazon SSM Managed Instance Core policy to allow EC2 instances to use AWS Systems Manager (SSM)
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role = aws_iam_role.pcluster_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
