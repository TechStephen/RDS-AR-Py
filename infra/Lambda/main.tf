resource "aws_lambda_function" "rds_api" {
  function_name    = "rdsAPIFunction"
  filename         = "${path.module}/functions.zip"
  handler          = "functions.lambda_handler"
  runtime          = "python3.11"
  role             = var.lambda_role_arn
  source_code_hash = filebase64sha256("${path.module}/functions.zip")
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rds_api.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.lambda_execution_arn}/*/*"
}