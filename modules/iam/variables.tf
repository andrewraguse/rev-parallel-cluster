# Variable for post install scripts bucket name
variable "post_install_scripts_bucket_name" {
  type = string
  description = "The bucket name storing the post install scripts"
}

# S3 bucket for post-install scripts
variable "output_files_bucket_name" {
  description = "Value for the S3 bucket to store output files"
  type = string
  sensitive = true
}