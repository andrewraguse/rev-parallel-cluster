# IAM module: Manages IAM roles, policies, and access controls for EC2 instances
module "iam" {
    source = "./modules/iam"  # Reference to IAM main module
    post_install_scripts_bucket_name = var.post_install_scripts_bucket_name # Passes the S3 bucket name to store post-install scripts
}

# Secrets Manager module: Manages the creation and storage of secrets (e.g., IAM access keys)
module "secrets_manager" {
    source = "./modules/secrets_manager" # Reference to Secrets Manager main module
    iam_access_keys = module.iam.iam_access_keys # Retrieves IAM access keys from the IAM module
    iam_user_names = module.iam.iam_user_names # Retrieves IAM usernames from the IAM module
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
module "parallel_cluster" {
  source = "./modules/parallel_cluster" # Reference to the ParallelCluster main module
  region = var.region # AWS region for the cluster
  api_stack_name = var.parallel_cluster_api_stack_name # Name of the API stack
  api_version = var.parallel_cluster_api_stack_version # API version
  private_subnet_id = var.parallel_cluster_private_subnet_id # Subnet for cluster instances
  public_subnet_id = var.parallel_cluster_public_subnet_id # Subnet for head
  cluster_region = var.region # Region for the cluster
  profile = var.profile # AWS profile for the cluster
  hs_username = var.hs_username # Username for HSDS configuration
  hs_password = var.hs_password # Password for HSDS configuration
  post_install_bucket = var.post_install_scripts_bucket_name # S3 bucket for post-install scripts
  pcluster_ec2_role = module.iam.pcluster_ec2_role # IAM role for EC2 instances in the cluster

  # Explicit dependencies to ensure the API stack is created before the cluster
  depends_on = [module.parallel_cluster_api]
}

# VPC module: Manages the virtual private cloud (VPC) and associated resources such as subnets
module "vpc" {
  source = "./modules/vpc" # Reference to the VPC main module
  private_subnet_cidr_block = var.private_subnet_cidr_block # CIDR block for the private subnet
  availability_zone = var.availability_zone # Availability zone for the VPC
}