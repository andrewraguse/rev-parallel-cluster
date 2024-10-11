# Get information about the current AWS account
data "aws_caller_identity" "current" {}

# Get the partition of the current AWS account (e.g., aws, aws-cn, aws-us-gov)
data "aws_partition" "current" {}