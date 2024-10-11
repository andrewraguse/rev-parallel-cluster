# Get current AWS caller identity
data "aws_caller_identity" "current" {}

# Retrieve the Lambda role name using an external script
data "external" "lambda_role_name" {
  program = ["bash", "${path.module}/get_lambda_role.sh"]
}