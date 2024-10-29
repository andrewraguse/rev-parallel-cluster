# Variable for EC2 describe policy
variable "ec2_describe_policy" {
    type = string
    description = "EC2 describe policy"
}

# Variable for IAM PassRole policy
variable "pass_and_attach_role_policy" {
    type = string
    description = "Allow for IAM PassRole"
}
