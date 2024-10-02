module "iam_groups" {
    source = "./groups"  # Reference to groups module
}

module "iam_users" {
    source = "./users"
    administrators_group_name = module.iam_groups.administrators_group_name  # Pass the output from the groups module
}