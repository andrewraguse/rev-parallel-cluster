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
}

variable "cluster_region" {
  description = "The region the clusters will be deployed in."
  type        = string
}

variable "profile" {
  type        = string
  description = "The AWS profile used to deploy the clusters."
}