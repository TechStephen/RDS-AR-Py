# resource "aws_secretsmanager_secret" "rds_credentials" {
#   name = "rds/mysql/app-creds"
#   description = "Credentials for RDS MySQL"
# }

# resource "aws_secretsmanager_secret_version" "rds_credentials_value" {
#   secret_id     = aws_secretsmanager_secret.rds_credentials.id
#   secret_string = jsonencode({
#     username = "db_user"
#     password = "supersecurepassword123"
#   })
# }

# Create RDS Database
resource "aws_db_instance" "my_rds" {
    db_name = "mydatabase"
    identifier              = "my-rds-instance"
    engine                 = "mysql"
    engine_version         = "8.0"
    instance_class         = "db.t3.micro"
    allocated_storage      = 20
    storage_type           = "gp2"
    db_subnet_group_name   = var.subnet_group_name
    vpc_security_group_ids = [aws_security_group.my_rds_sg.id]
    username               = "db_user"
    password               = "supersecurepassword123"
    skip_final_snapshot    = true
    publicly_accessible    = true

    tags = {
        Name    = "MyRDSInstance"
    }
}

# Create Security Group for RDS
resource "aws_security_group" "my_rds_sg" {
    name        = "my_rds_sg"
    description = "Security group for RDS instance"
    vpc_id      = var.vpc_id
    
    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}