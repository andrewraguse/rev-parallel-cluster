output "pcluster_ec2_role" {
    value = aws_iam_role.pcluster_ec2_role.arn
    description = "Role attached to parallel cluster ec2 instances"
}