# Creates REST API
resource "aws_api_gateway_rest_api" "rest_api" {
  name        = "rest_api"
  description = "API Gateway for the Lambda function"   
}

# Creates API Link /get_items
resource "aws_api_gateway_resource" "get_items_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "get_items"
}

# Creates GET Method for /get_items
resource "aws_api_gateway_method" "get_items_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.get_items_resource.id
  http_method   = "GET"
  authorization = "NONE" # Can Authorize through IAM/Cognito/Etc.
}

# Integrates /get-items endpoint with Lambda function
resource "aws_api_gateway_integration" "get_items_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.get_items_resource.id
  http_method = aws_api_gateway_method.get_items_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = var.invoke_arn
}

# Creates API Link /put_items
resource "aws_api_gateway_resource" "put_items_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "put_items"
}

# Creates GET Method for /put_items
resource "aws_api_gateway_method" "put_item_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.put_items_resource.id
  http_method   = "POST"
  authorization = "NONE" # Can Authorize through IAM/Cognito/Etc.
}

# Integrates /put-items endpoint with Lambda function
resource "aws_api_gateway_integration" "put_items_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.put_items_resource.id
  http_method = aws_api_gateway_method.put_item_method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = var.invoke_arn
}

# Deploys API Gateway Stage
resource "aws_api_gateway_stage" "stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  stage_name    = "prod"
}

# Deploys API Gateway
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.get_items_integration, aws_api_gateway_integration.put_items_integration]
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
}