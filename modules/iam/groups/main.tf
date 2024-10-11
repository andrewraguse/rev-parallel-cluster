# IAM Group for administrators
resource "aws_iam_group" "administrators" {
  name = "administrators"
}

# Attach AdministratorAccess policy to the administrators group
resource "aws_iam_policy_attachment" "administrators_attach" {
  name       = "adminstrators_attach"
  groups     = [aws_iam_group.administrators.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"

  # Ignore changes to the 'users' attribute
  lifecycle {
    ignore_changes = [users]
  }
}
