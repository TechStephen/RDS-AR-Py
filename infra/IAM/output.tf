output "role_arn" {
  value = aws_iam_role.app_runner_role.arn 
}

output "role_name" {
  value = aws_iam_role.app_runner_role.name 
}

output "role_policy_arn" {
  value = aws_iam_policy.app_runner_policy.arn 
}
