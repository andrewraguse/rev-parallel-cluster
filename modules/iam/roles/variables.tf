variable "post_install_scripts_read_bucket_policy" {
    type = string
    description = "Post install script bucket policy to attach to role"
}

variable "ec2_describe_policy" {
    type = string
    description = "EC2 describe policy"
}

variable "cloudformation_policy" {
    type = string
    description = "Allows interaction with cloudformation stacks"
}

variable "autoscaling_policy" {
    type = string
    description = "Allow autoscaling permissions"
}

variable "pass_role_policy" {
    type = string
    description = "Allow for iam passrole"
  
}