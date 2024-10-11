# AWS provider: Configures the AWS provider with the specified region and profile.
# This is necessary for Terraform to interact with AWS resources.
provider "aws" {
    region  = var.region  # AWS region where resources will be created
    profile = var.profile # AWS profile to authenticate (from AWS credentials)
}

# AWS ParallelCluster provider: Configures the ParallelCluster provider.
# This is used for managing AWS ParallelCluster resources via Terraform.
provider "aws-parallelcluster" {
    region         = var.region  # AWS region for ParallelCluster resources
    profile        = var.profile # AWS profile for authentication
    api_stack_name = var.parallel_cluster_api_stack_name # Name of the API stack for ParallelCluster
    use_user_role  = true  # Specifies whether to use the IAM role of the current user (true enables this)
}