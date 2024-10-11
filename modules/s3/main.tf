# S3 bucket for Terraform state files
resource "aws_s3_bucket" "terraform_state" {
 bucket = var.terraform_state_s3_bucket_name
}

# Enable versioning for the Terraform state bucket
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
 bucket = aws_s3_bucket.terraform_state.id
 versioning_configuration {
  status = "Enabled"
 }
}

# S3 bucket used for post-install scripts
resource "aws_s3_bucket" "post_install_scripts" {
 bucket = var.post_install_scripts_bucket_name
}