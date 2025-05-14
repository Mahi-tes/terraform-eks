resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
      Name = var.vpc_name
    }
}

resource "aws_subnet" "public_az1_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet1_cidrblock
    availability_zone = var.az1_availabilityzone
    map_public_ip_on_launch = true

    tags = {
        Name = var.subnet1_name
    }
}

resource "aws_subnet" "public_az2_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = var.subnet2_cidrblock
    availability_zone = var.az2_availabilityzone
    map_public_ip_on_launch = true

    tags = {
        Name = var.subnet2_name
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      Name = var.igw_name
    }
}

resource "aws_route_table" "public_subnet_routetable" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = var.public_route_name
  }
}

resource "aws_route_table_association" "routeassociation_az1" {
  subnet_id = aws_subnet.public_az1_subnet.id
  route_table_id = aws_route_table.public_subnet_routetable.id
}

resource "aws_route_table_association" "routeassociation_az2" {
  subnet_id = aws_subnet.public_az2_subnet.id
  route_table_id = aws_route_table.public_subnet_routetable.id
}

resource "aws_security_group" "securitygroup" {
    vpc_id = aws_vpc.my_vpc.id

    ingress {
        from_port =22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port =80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  

    ingress {
        from_port =443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    

    ingress {
        from_port =3000
        to_port = 11000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  

    ingress {
        from_port =30000
        to_port = 32767
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = var.securitygroup_name
    }

  
}