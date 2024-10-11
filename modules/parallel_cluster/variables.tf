variable "region" {
  type        = string
  description = "The region to deploy the ParallelCluster API."
}

variable "api_stack_name" {
  type        = string
  description = "The name of the CloudFormation stack used to deploy the ParallelCluster API."
}

variable "api_version" {
  type        = string
  description = "The version of the ParallelCluster API."
}

variable "private_subnet_id" {
  type        = string
  description = "The id of the subnet to be used for the ParallelCluster compute instances."
  sensitive = true
}

variable "cluster_region" {
  description = "The region the clusters will be deployed in."
  type        = string
}

variable "profile" {
  type        = string
  description = "The AWS profile used to deploy the clusters."
}

# Used for HSDS module

variable "hs_username" {
  description = "The username for the HSDS service"
  type        = string
  sensitive   = true  # Mark this variable as sensitive
}

variable "hs_password" {
  description = "The password for the HSDS service"
  type        = string
  sensitive   = true  # Mark this variable as sensitive
}

variable "post_install_bucket" {
  description = "The bucket name used to store the post_install scripts"
  type        = string
  sensitive   = true  # Mark this variable as sensitive
}

variable "pcluster_ec2_role" {
  default = "The role to attach to ec2 instances"
  type = string
  
}