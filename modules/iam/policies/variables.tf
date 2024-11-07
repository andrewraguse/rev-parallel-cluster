# Variable for the S3 bucket name that holds post-install scripts
variable "post_install_scripts_bucket_name" {
  type = string
  description = "Bucket name used to hold the post install scripts accessed by docker"
  sensitive = true
}

# S3 bucket for post-install scripts
variable "output_files_bucket_name" {
  description = "Value for the S3 bucket to store output files"
  type = string
  sensitive = true
}