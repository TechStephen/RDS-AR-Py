terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    
    required_version = ">= 1.0"
}

provider "aws" {
    region = "us-east-1"
}

module "VPC" {
    source = "./VPC"
}

module "APIGateway" {
    source = "./APIGateway"
    invoke_arn = module.Lambda.invoke_arn
}

module "Lambda" {
    source = "./Lambda"
    lambda_role_arn = module.IAM.lambda_exec_role_arn
    lambda_execution_arn = module.APIGateway.api_gateway_rest_api_execution_arn
}

module "RDS" {
    source     = "./RDS"
    vpc_id     = module.VPC.vpc_id
    subnet_group_name = module.VPC.subnet_group_name
}

module "IAM" {
    source = "./IAM"
}

module "AppRunner" {
    source = "./AppRunner"
}

