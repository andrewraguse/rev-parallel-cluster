# Variable for the AWS region where the ParallelCluster API will be deployed
variable "region" {
 type = string
 description = "The region to deploy the ParallelCluster API."
}

# Variable for the CloudFormation stack name for the ParallelCluster API
variable "api_stack_name" {
 type = string
 description = "The name of the CloudFormation stack used to deploy the ParallelCluster API."
}

# Variable for the version of the ParallelCluster API
variable "api_version" {
 type = string
 description = "The version of the ParallelCluster API."
}