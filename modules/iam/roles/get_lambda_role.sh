#!/bin/bash
role_name=$(aws iam list-roles --query 'Roles[?starts_with(RoleName, `ParallelClusterLambdaRole-`)].RoleName' --output text)
echo "{\"role_name\": \"$role_name\"}"