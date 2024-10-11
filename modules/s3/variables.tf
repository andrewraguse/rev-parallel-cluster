variable "terraform_state_s3_bucket_name" {
    type = string
    description = "The unique s3 bucket name to store terraform state files."
}

variable "post_install_scripts_bucket_name" {
    type = string
    description = "The unique s3 bucket name to store post install scripts."
}