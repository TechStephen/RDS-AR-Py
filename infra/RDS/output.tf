output "rds_instance_id" {
  value = aws_db_instance.my_rds.id
}

output "rds_instance_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}