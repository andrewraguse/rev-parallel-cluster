# Variable for the S3 bucket name that holds post-install scripts
variable "post_install_scripts_bucket_name" {
  type = string
  description = "Bucket name used to hold the post install scripts accessed by docker"
}