# Variable for post install script read bucket policy
variable "post_install_scripts_read_bucket_policy" {
    type = string
    description = "Post install script bucket policy to attach to role"
}

# Variable for EC2 describe policy
variable "ec2_describe_policy" {
    type = string
    description = "EC2 describe policy"
}

# Variable for CloudFormation interaction policy
variable "cloudformation_policy" {
    type = string
    description = "Allows interaction with CloudFormation stacks"
}

# Variable for AutoScaling policy
variable "autoscaling_policy" {
    type = string
    description = "Allow AutoScaling permissions"
}

# Variable for IAM PassRole policy
variable "pass_role_policy" {
    type = string
    description = "Allow for IAM PassRole"
}
