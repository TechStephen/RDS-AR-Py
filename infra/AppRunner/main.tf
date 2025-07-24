resource "aws_apprunner_service" "ar_service" {
  service_name = "ar_service"
  
  instance_configuration {
    instance_role_arn = var.instance_role_arn
  }

  source_configuration {
    image_repository {
      image_configuration {
        port = "8000"
      }
      image_identifier      = "767398032512.dkr.ecr.us-east-1.amazonaws.com/rds-test:latest"
      image_repository_type = "ECR_PUBLIC"
    }
    auto_deployments_enabled = false
  }

  tags = {
    Name = "Apprunner-service"
  }
}