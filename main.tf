# IAM module: Manages IAM roles, policies, and access controls for EC2 instances
module "iam" {
    source = "./modules/iam"  # Reference to IAM main module
    post_install_scripts_bucket_name = var.post_install_scripts_bucket_name # Passes the S3 bucket name to store post-install scripts
}

# S3 module: Handles the creation and configuration of S3 buckets for Terraform state and post-install scripts
module "s3" {
    source = "./modules/s3" # Reference to the S3 main module
    terraform_state_s3_bucket_name = var.terraform_state_s3_bucket_name # Bucket for storing Terraform state files
    post_install_scripts_bucket_name = var.post_install_scripts_bucket_name # Bucket for storing post-install scripts
}

# CloudWatch module: Sets up CloudWatch alarms and monitors billing/spending alerts
module "cloudwatch" {
  source = "./modules/cloudwatch" # Reference to the CloudWatch module for monitoring
  account_id = data.aws_caller_identity.current.account_id # Uses the current AWS account ID
  aws_profile = var.profile # AWS profile for authentication
  sns_alert_emails = var.sns_alert_emails # List of email addresses to receive billing alerts
  spending_alert_threshold = var.spending_alert_threshold # Threshold for sending billing/spending alerts

  providers = {
    aws = aws.us_east_1
  }
}

# Budgets module: Creates and manages AWS budgets for cost control, including spending alerts
module "budgets" {
  source = "./modules/aws_budgets" # Reference to the AWS Budgets module
  alert_emails = var.sns_alert_emails # List of emails to receive budget alerts
  monthly_spend_limit = var.monthly_spend_limit # Monthly spend limit for the AWS account
}

# Parallel Cluster API module: Manages the API stack for AWS ParallelCluster to interact with AWS HPC environment
module "parallel_cluster_api" {
  source = "./modules/parallel_cluster_api" # Reference to the ParallelCluster API main module
  region = var.region # AWS region for the ParallelCluster API stack
  api_stack_name = var.parallel_cluster_api_stack_name # Name of the API stack for ParallelCluster
  api_version = var.parallel_cluster_api_stack_version # Version of the API stack
}

# Parallel Cluster module: Provisions the AWS ParallelCluster for HPC workloads
# RemoveComment
/*
module "parallel_cluster" {
  source = "./modules/parallel_cluster" # Reference to the ParallelCluster main module
  region = var.region # AWS region for the cluster
  api_stack_name = var.parallel_cluster_api_stack_name # Name of the API stack
  api_version = var.parallel_cluster_api_stack_version # API version
  subnet_id = var.subnet_id # Subnet for head
  cluster_region = var.region # Region for the cluster
  profile = var.profile # AWS profile for the cluster
  post_install_bucket = var.post_install_scripts_bucket_name # S3 bucket for post-install scripts
  pass_and_attach_role_policy = module.iam.pass_and_attach_role_policy # Pass role policy for the head node
  s3_readonly_post_install_scripts_policy = module.iam.s3_readonly_post_install_scripts_policy # s3 read policy for compute nodes

  # Explicit dependencies to ensure the API stack is created before the cluster
  depends_on = [module.parallel_cluster_api]
}
*/