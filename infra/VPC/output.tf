output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_group_name" {
  value = aws_db_subnet_group.subnet_group.name
}       