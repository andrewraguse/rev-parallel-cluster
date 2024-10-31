### Lambda Roles

# Pass role attachment
# RemoveComment
/*
resource "aws_iam_role_policy_attachment" "pass_and_attach_role_policy_attachment_lambda" {
  role = data.external.lambda_role_name.result["role_name"]
  policy_arn = var.pass_and_attach_role_policy
}
*/


# Attach the EC2 Describe Instances policy to the EC2 role
# RemoveComment
/*
resource "aws_iam_role_policy_attachment" "ec2_describe_policy_attachment_lambda" {
  role = data.external.lambda_role_name.result["role_name"]
  policy_arn = var.ec2_describe_policy
}
*/

