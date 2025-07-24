variable "lambda_role_arn" {
  description = "The ARN of the IAM role to associate with the Lambda function."
  type        = string
}

variable "lambda_execution_arn" {
  description = "The ARN of the Lambda function to be invoked by the API Gateway."
  type        = string  
}