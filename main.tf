module "iam" {
    source = "./modules/iam"  # Reference to IAM main module
    post_install_scripts_bucket_name = var.post_install_scripts_bucket_name
}

module "secrets_manager" {
    source = "./modules/secrets_manager" # Reference to Secrets Manager main module
    iam_access_keys = module.iam.iam_access_keys
    iam_user_names = module.iam.iam_user_names
}

module "s3" {
    source = "./modules/s3" # Reference to the s3 main module
    terraform_state_s3_bucket_name = var.terraform_state_s3_bucket_name
    post_install_scripts_bucket_name = var.post_install_scripts_bucket_name
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  account_id = data.aws_caller_identity.current.account_id
  aws_profile = var.profile
  sns_alert_emails = var.sns_alert_emails
  spending_alert_threshold = var.spending_alert_threshold
}

module "budgets" {
  source = "./modules/aws_budgets"
  alert_emails = var.sns_alert_emails
  monthly_spend_limit = var.monthly_spend_limit
}

module "parallel_cluster_api" {
  source = "./modules/parallel_cluster_api" # Reference to the parallel cluster api main module
  region = var.region
  api_stack_name = var.parallel_cluster_api_stack_name
  api_version = var.parallel_cluster_api_stack_version
}

module "parallel_cluster" {
  source = "./modules/parallel_cluster" # Reference to the parallel cluster main module
  region = var.region
  api_stack_name = var.parallel_cluster_api_stack_name
  api_version = var.parallel_cluster_api_stack_version
  private_subnet_id = var.parallel_cluster_private_subnet_id
  cluster_region = var.region
  profile = var.profile
  hs_username = var.hs_username
  hs_password = var.hs_password
  post_install_bucket = var.post_install_scripts_bucket_name
  pcluster_ec2_role = module.iam.pcluster_ec2_role

  # Explicit dependencies
  depends_on = [module.parallel_cluster_api]
}

module "vpc" {
  source = "./modules/vpc" # Reference to the vpc main module
  private_subnet_cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
}