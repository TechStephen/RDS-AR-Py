# Create .zip
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/functions.py"
  output_path = "${path.module}/functions.zip"
}

# Creates lambda function with python code
resource "aws_lambda_function" "rds_api" {
  filename      = "lambda_function.zip"
  function_name = "dynamoGetAll"
  role          = var.lambda_role_arn
  runtime       = "python3.11"
  handler       = "functions.lambda_handler"
  
  source_code_hash = data.archive_file.lambda.output_base64sha256
}

# Creates permission for api gateway to use function 
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rds_get_all.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.lambda_execution_arn 
}