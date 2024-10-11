# Resource to store AWS access keys in Secrets Manager for IAM users
# TODO: Add a Lambda function to rotate these keys
resource "aws_secretsmanager_secret" "aws_access_keys" {
  for_each = { for user in var.iam_user_names : user.user_name => user }
  name     = "${each.value.user_name}_user_credentials" # The name of the secret in Secrets Manager
  
  # The access keys themselves will not be output or stored in the state
  provisioner "local-exec" {
    command = <<EOT
      aws secretsmanager create-secret \
        --name "${each.key}_user_credentials" \
        --secret-string "{\"access_key_id\":\"${var.iam_access_keys[each.value.user_name].access_key_id}\",\"secret_access_key\":\"${var.iam_access_keys[each.value.user_name].secret_key}\"}"
    EOT
  }
}
