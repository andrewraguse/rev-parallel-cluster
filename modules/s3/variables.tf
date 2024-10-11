# The unique S3 bucket name to store Terraform state files.
variable "terraform_state_s3_bucket_name" {
 type = string
 description = "The unique s3 bucket name to store terraform state files."
}

# The unique S3 bucket name to store post-install scripts.
variable "post_install_scripts_bucket_name" {
 type = string
 description = "The unique s3 bucket name to store post install scripts."
}