# Module for managing IAM groups
module "iam_groups" {
  source = "./groups"
}

# Module for managing IAM policies
module "iam_policies" {
  source = "./policies"  # Reference to policies module
  post_install_scripts_bucket_name = var.post_install_scripts_bucket_name  # Pass bucket name for post install scripts
  output_files_bucket_name = var.output_files_bucket_name # Pass name for output files bucket
}

# Module for managing IAM roles
module "iam_roles" {
  source = "./roles"
  ec2_describe_policy = module.iam_policies.ec2_describe_policy  # Pass EC2 describe policy
  pass_and_attach_role_policy = module.iam_policies.pass_and_attach_role_policy  # Pass PassRole policy
}
