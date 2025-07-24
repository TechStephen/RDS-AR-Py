output "role_arn" {
  value = module.IAM.role_arn
}

output "role_name" {
  value = module.IAM.role_name  
}

output "role_policy_arn" {
  value = module.IAM.role_policy_arn
}

output "rds_id" {
    value = module.RDS.rds_instance_id
}

output "rds_endpoint" {
    value = module.RDS.rds_instance_endpoint
}

output "rds_port" {
  value = module.RDS.rds_instance_port
}