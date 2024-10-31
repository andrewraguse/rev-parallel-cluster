# Variable for the AWS region to deploy the ParallelCluster API
variable "region" {
 type = string
 description = "The region to deploy the ParallelCluster API."
}

# Variable for the name of the CloudFormation stack for the ParallelCluster API
variable "api_stack_name" {
 type = string
 description = "The name of the CloudFormation stack used to deploy the ParallelCluster API."
}

# Variable for the version of the ParallelCluster API
variable "api_version" {
 type = string
 description = "The version of the ParallelCluster API."
}

# Variable for the subnet ID used for ParallelCluster head node
variable "subnet_id" {
 type = string
 description = "The id of the subnet to be used for the ParallelCluster head node."
 sensitive = true
}

# Variable for the region where the clusters will be deployed
variable "cluster_region" {
 description = "The region the clusters will be deployed in."
 type = string
}

# Variable for the AWS profile used to deploy the clusters
variable "profile" {
 type = string
 description = "The AWS profile used to deploy the clusters."
}

# Variable for the bucket name used to store the post install scripts
variable "post_install_bucket" {
 description = "The bucket name used to store the post_install scripts"
 type = string
 sensitive = true # Mark this variable as sensitive
}

# Variable for the pass role policy
variable "pass_and_attach_role_policy" {
  description = "Pass role policy for the head node"
  type = string
  sensitive = true
}

# Variable for s3 read post install script policy
variable "s3_readonly_post_install_scripts_policy" {
  description = "s3 read policy for compute node"
  type = string
  sensitive = true
}