# Data source to fetch the default VPC
data "aws_vpc" "default" {
  default = true
}