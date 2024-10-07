provider "aws" {
    region = var.region
    profile = var.profile
}

provider "aws-parallelcluster" {
    region = var.region
    profile = var.profile
    api_stack_name = var.parallel_cluster_api_stack_name
    use_user_role  = true
}