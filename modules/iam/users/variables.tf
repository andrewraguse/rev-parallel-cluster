# Variable for the administrators IAM group name
variable "administrators_group_name" {
  type = string
  description = "The name of the administrators IAM group"
}

# Variable for IAM users
variable "iam_users" {
  type = list(object({
    user_name = string,
    type = string
  }))
  default = [
    {
      user_name = "lead_developer",
      type = "administrator"
    }
  ]
}
