# AWS region variable
variable "region" {
  description = "The AWS region where resources will be created"
  type = string
  default = "us-west-2"  # Optional default value
}

# Availability zone variable for hosting parallel cluster subnets
variable "availability_zone" {
  description = "Availability zone to be used for hosting the parallel cluster subnets"
  type = string
  default = "us-west-2a"
}

# AWS profile variable
variable "profile" {
  description = "The AWS profile where resources will be created"
  type = string
  default = null  # Optional default value
}

# VPC variables

# CIDR block for the private subnet
variable "private_subnet_cidr_block" {
  description = "Value for the private subnet CIDR block"
  type = string
  sensitive = true
}

# S3 bucket variables

# S3 bucket for Terraform state storage
variable "terraform_state_s3_bucket_name" {
  description = "Value for the S3 bucket to store the Terraform state configs"
  type = string
  sensitive = true
}

# S3 bucket for post-install scripts
variable "post_install_scripts_bucket_name" {
  description = "Value for the S3 bucket to store post-install scripts used for Docker containers"
  type = string
  sensitive = true
}

# Parallel Cluster variables

# Version of the ParallelCluster API
variable "parallel_cluster_api_stack_version" {
  type = string
  description = "The version of the ParallelCluster API"
  default = "3.10.0"  # Optional default value
}

# CloudFormation stack name for the ParallelCluster API
variable "parallel_cluster_api_stack_name" {
  type = string
  description = "The name of the CloudFormation stack used to deploy the ParallelCluster API."
  default = "ParallelCluster"  # Optional default value
}

# Subnet ID for the ParallelCluster
variable "parallel_cluster_private_subnet_id" {
  type = string
  description = "The subnet ID to be used for the ParallelCluster"
  sensitive = true
}

# Budget and CloudWatch variables

# List of emails for SNS alerts
variable "sns_alert_emails" {
  type = list(string)
  description = "The email addresses to send alarm notifications to"
}

# Spending limit threshold for CloudWatch alerts
variable "spending_alert_threshold" {
  type = number
  description = "The spending limit in USD to trigger an alert."
}

# Monthly spending limit for the budget
variable "monthly_spend_limit" {
  type = number
  description = "The maximum amount that the account should spend in a month."
}

# HSDS service variables

# Username for the HSDS service
variable "hs_username" {
  description = "The username for the HSDS service"
  type = string
  sensitive = true  # Mark this variable as sensitive
}

# Password for the HSDS service
variable "hs_password" {
  description = "The password for the HSDS service"
  type = string
  sensitive = true  # Mark this variable as sensitive
}