# Create vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "MyVPC"
    }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true 
    tags = {
        Name = "PublicSubnet"
    }
}

# Create IGW
resource "aws_internet_gateway" "main_gw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
        Name = "MainInternetGateway"
    }
}

# Create Route Table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    
    tags = {
        Name = "PublicRouteTable"
    }
}

# Create Route
resource "aws_route" "public_route" {
    route_table_id         = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.main_gw.id

    depends_on = [aws_internet_gateway.main_gw]
}

# Create RTA
resource "aws_route_table_association" "public_rta" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route_table.id
}