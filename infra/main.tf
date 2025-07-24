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

module "RDS" {
    source     = "./RDS"
    subnet_id  = module.VPC.subnet_id
    vpc_id     = module.VPC.vpc_id
}

module "IAM" {
    source = "./IAM"
}

module "AppRunner" {
    source = "./AppRunner"
    instance_role_arn = module.IAM.role_arn
}

