module "iam" {
    source = "./modules/iam"  # Reference to IAM main module
}

module "secrets_manager" {
    source = "./modules/secrets_manager" # Reference to Secrets Manager main module
    iam_access_keys = module.iam.iam_access_keys
    iam_user_names = module.iam.iam_user_names
}

module "s3" {
    source = "./modules/s3" # Reference to the s3 main module
    terraform_state_s3_bucket_name = var.terraform_state_s3_bucket_name
}

module "parallel_cluster" {
  source = "./modules/parallel_cluster" # Reference to the parallel cluster main module
  region = var.region
}

module "vpc" {
  source = "./modules/vpc" # Reference to the vpc main module
  private_subnet_cidr_block = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
}

# Step x: Remove this block of code once running terraform init
terraform {
  backend "s3" {
    # Step x.1: Insert custom bucket name (must be unique)
    bucket = "<insert-terraform-state-s3-bucket>" # Name of your S3 bucket
    key = "terraform.tfstate" # Path inside the bucket for the state file
    region = "us-west-2" # AWS region where the bucket is located
    encrypt = true # Enable encryption
  }
}