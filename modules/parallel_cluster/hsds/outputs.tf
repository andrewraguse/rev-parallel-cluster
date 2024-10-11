# Output the ECR repository URL for further use
output "ecr_repository_url" {
  value = aws_ecr_repository.hsds.repository_url
}