terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws-parallelcluster = {
      source  = "aws-tf/aws-parallelcluster"
      version = "1.0.0"
    }
  }
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