variable "region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-west-2"  # Optional default value
}

variable "terraform_state_s3_bucket_name" {
  description = "Value for s3 bucket to store the terraform state configs"
  type = string
}

variable "private_subnet_cidr_block" {
  description = "Value for the private subnet cidr block"
  type = string
}

variable "availability_zone" {
  description = "Availability zone to be used for hosting the parallel cluser subnets"
  type = string
  default = "us-west-2a"
}