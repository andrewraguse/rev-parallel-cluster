# Output the name of the administrators IAM group
output "administrators_group_name" {
  value       = aws_iam_group.administrators.name
  description = "The name of the administrators IAM group"
}