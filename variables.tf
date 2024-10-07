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

variable "profile" {
  description = "The AWS profile where resources will be created"
  type = string
  default = null  # Optional default value
}

variable "parallel_cluster_api_stack_version" {
  type = string
  description = "The version of the parallel cluster api"
  default = "3.10.0" # Optional default value
}

variable "parallel_cluster_api_stack_name" {
  type = string
  description = "The name of the CloudFormation stack used to deploy the ParallelCluster API."
  default = "ParallelCluster" # Optional default value
}

variable "parallel_cluster_private_subnet_id" {
  type = string
  description = "The subnet id to be used for the parallel cluster"
}