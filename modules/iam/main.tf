# Module for managing IAM groups
module "iam_groups" {
  source = "./groups"
}

# Module for managing IAM users
module "iam_users" {
  source = "./users" 
  administrators_group_name = module.iam_groups.administrators_group_name  # Pass the output from the groups module
}

# Module for managing IAM policies
module "iam_policies" {
  source = "./policies"  # Reference to policies module
  post_install_scripts_bucket_name = var.post_install_scripts_bucket_name  # Pass bucket name for post install scripts
}

# Module for managing IAM roles
module "iam_roles" {
  source = "./roles"
  post_install_scripts_read_bucket_policy = module.iam_policies.s3_post_install_bucket_read_policy  # Pass policy for post install scripts
  ec2_describe_policy = module.iam_policies.ec2_describe_policy  # Pass EC2 describe policy
  autoscaling_policy = module.iam_policies.autoscaling_policy  # Pass autoscaling policy
  cloudformation_policy = module.iam_policies.cloudformation_policy  # Pass CloudFormation policy
  pass_role_policy = module.iam_policies.pass_role_policy  # Pass PassRole policy
}
