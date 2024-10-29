# Terraform configuration block: Specifies required Terraform version and providers.
terraform {
  required_version=">= 1.5.7"
  required_providers {
    aws-parallelcluster = {
      source="aws-tf/aws-parallelcluster"
      version="1.0.0"
    }
     aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Adjust this version according to your needs
    }
  }
}

# Terraform backend configuration block: Specifies the S3 backend for storing the state file.
# This block should be uncommented out after running `terraform init` and `terraform apply` once
# to wait for the s3 bucket creation
# RemoveComment
/*
terraform {
  backend "s3" {
    # S3 bucket configuration to store the state file
    bucket="insert-your-bucket-name" # Name of your S3 bucket
    key="terraform.tfstate" # Path inside the bucket for the state file
    region="us-west-2" # AWS region where the bucket is located
    encrypt=true # Enable encryption
  }
}
*/
