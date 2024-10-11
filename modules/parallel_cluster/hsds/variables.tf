variable "hs_username" {
    description = "The username for the HSDS service"
    type        = string
    sensitive   = true  # Mark this variable as sensitive
}

variable "hs_password" {
    description = "The password for the HSDS service"
    type        = string
    sensitive   = true  # Mark this variable as sensitive
}

variable "region" {
  description = "The AWS region to deploy the resources."
  type        = string
  default     = "us-west-2"
}

variable "docker_image_tag" {
  description = "The tag for the Docker image."
  type        = string
  default     = "latest"
}

variable "post_install_bucket" {
  description = "The bucket name used to store the post_install scripts"
  type        = string
  sensitive   = true  # Mark this variable as sensitive
}