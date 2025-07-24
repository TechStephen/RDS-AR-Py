variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be created."
  type        = string  
}

variable "subnet_group_name" {
  description = "The name of the DB subnet group to associate with the RDS instance."
  type        = string  
}