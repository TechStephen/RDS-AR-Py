resource "aws_iam_policy" "app_runner_policy" {
  name        = "app-runner-policy"
  description = "Policy for App Runner to access RDS and ECR"

  policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "secretsmanager:GetSecretValue",
      "Resource": "arn:aws:secretsmanager:us-east-1:123456789012:secret:rds/mysql/app-creds-*"
    }
  ]
})
}

resource "aws_iam_role" "app_runner_role" {
  name = "app-runner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "build.apprunner.amazonaws.com"
        }
      }
    ]
  }) 
}

resource "aws_iam_role_policy_attachment" "app_runner_policy_attachment" {
  role       = aws_iam_role.app_runner_role.name
  policy_arn = aws_iam_policy.app_runner_policy.arn
}