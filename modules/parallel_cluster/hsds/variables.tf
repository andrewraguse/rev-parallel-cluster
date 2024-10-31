# Variable for the AWS region
variable "region" {
  description = "The AWS region to deploy the resources."
  type = string
  default = "us-west-2"
}

# Variable for post install scripts bucket name
variable "post_install_bucket" {
  description = "The bucket name used to store the post_install scripts"
  type = string
  sensitive = true
}