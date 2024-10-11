module "iam_groups" {
    source = "./groups"  # Reference to groups module
}

module "iam_users" {
    source = "./users"
    administrators_group_name = module.iam_groups.administrators_group_name  # Pass the output from the groups module
}

module "iam_policies" {
    source = "./policies"
    post_install_scripts_bucket_name = var.post_install_scripts_bucket_name
}

module "iam_roles" {
    source = "./roles"
    post_install_scripts_read_bucket_policy = module.iam_policies.s3_post_install_bucket_read_policy
    ec2_describe_policy = module.iam_policies.ec2_describe_policy
    autoscaling_policy = module.iam_policies.autoscaling_policy
    cloudformation_policy = module.iam_policies.cloudformation_policy
}