# This data source fetches details about the current AWS caller identity.
# It returns the AWS account ID, the AWS ARN (Amazon Resource Name), and the user ID.
# Useful for dynamically obtaining account details without hardcoding them.
data "aws_caller_identity" "current" {}