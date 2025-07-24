variable "subnet_id" {
  description = "The ID of the subnet to associate with the RDS instance."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be created."
  type        = string  
}