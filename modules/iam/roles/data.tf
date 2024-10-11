data "aws_caller_identity" "current" {}

data "external" "lambda_role_name" {
  program = ["bash", "${path.module}/get_lambda_role.sh"]
}