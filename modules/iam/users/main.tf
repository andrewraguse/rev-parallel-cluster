# Create a lead_developer iam user
resource "aws_iam_user" "iam_users" {
    for_each = { for user in var.iam_users : user.user_name => user}
    name = each.value.user_name
}

# Add the lead_developer to the administrators group for full access
resource "aws_iam_group_membership" "administrators_users_membership" {
    for_each = { for user in var.iam_users : user.user_name => user if user.type == "administrator"}
    name = "${each.key}_administrators_users_membership"
    users = [each.value.user_name]
    group = var.administrators_group_name
}
        

# Create access keys for programmatic access (API/CLI) for the IAM users
resource "aws_iam_access_key" "user_access_keys" {
    for_each = { for user in var.iam_users : user.user_name => user}
    user = each.value.user_name
}

# Create a login profile for the IAM user (password-based console access)
resource "aws_iam_user_login_profile" "console_user_profiles" {
    for_each = { for user in var.iam_users : user.user_name => user}
    user = each.value.user_name  # The IAM user to attach this login profile to
}