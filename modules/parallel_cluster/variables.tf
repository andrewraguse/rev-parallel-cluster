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

# Variable for the subnet ID used for ParallelCluster compute instances
variable "private_subnet_id" {
 type = string
 description = "The id of the subnet to be used for the ParallelCluster compute instances."
 sensitive = true
}

# Variable for the subnet ID used for ParallelCluster head node
variable "public_subnet_id" {
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

# Variable for the username for the HSDS service
variable "hs_username" {
 description = "The username for the HSDS service"
 type = string
 sensitive = true  # Mark this variable as sensitive
}

# Variable for the password for the HSDS service
variable "hs_password" {
 description = "The password for the HSDS service"
 type = string
 sensitive = true # Mark this variable as sensitive
}

# Variable for the bucket name used to store the post install scripts
variable "post_install_bucket" {
 description = "The bucket name used to store the post_install scripts"
 type = string
 sensitive = true # Mark this variable as sensitive
}

# Variable for the role to attach to EC2 instances
variable "pcluster_ec2_role" {
 description = "The role to attach to ec2 instances"
 type = string
}