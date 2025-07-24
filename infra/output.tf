output "rds_id" {
    value = module.RDS.rds_instance_id
}

output "rds_endpoint" {
    value = module.RDS.rds_instance_endpoint
}

output "api_url" {
  value = module.APIGateway.api_url
}