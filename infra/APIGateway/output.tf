output "api_url" {
  value = "https://${aws_api_gateway_rest_api.rest_api.id}.execute-api.${"us-east-1"}.amazonaws.com/${aws_api_gateway_stage.stage.stage_name}"
}

output "api_gateway_rest_api_execution_arn" {
  value = aws_api_gateway_rest_api.rest_api.execution_arn
}