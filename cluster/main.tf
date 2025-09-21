data "aws_ami" "al2023" {
  most_recent = true
  owners = [ "137112412989" ]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
# resource "aws_vpc" "main_vpc" {
#   cidr_block           = var.vpc-cidr
#   enable_dns_hostnames = true
#   enable_dns_support   = true

# }

resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public-subnet-cidr
  availability_zone       = var.AZ
  map_public_ip_on_launch = true

}
resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private-subnet-cidr
  availability_zone = var.AZ

}
resource "aws_instance" "public_ec2" { 

  ami = data.aws_ami.al2023.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [var.SG_nginx_id]
  key_name = var.key_name
  tags = {
    Name = "publicInstance"

  }
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl start nginx
              systemctl enable nginx
EOF


}

resource "aws_instance" "private_ec2" { 

  ami = data.aws_ami.al2023.id

  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_subnet.id
  vpc_security_group_ids = [var.SG_appache_id]
  key_name = var.key_name
  tags = {
    Name = "privateInstance"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              echo "Hello from Apache server on $(hostname -f)" | sudo tee /var/www/html/index.html

EOF

}

resource "aws_eip" "nat_gateway_eip_a" {
  domain = "vpc"
  tags = {
    Name = "nat-gateway-eip"
  }
}
resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_gateway_eip_a.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "example-nat-gateway"
  }
  depends_on = [var.IGW_id] # ensure IGW exists before NAT
}



#
#resource "aws_eip" "nat_gateway_eip_b" {
#  domain = "vpc"
#  tags = {
#    Name = "nat-gateway-eip"
#  }
#}
#resource "aws_nat_gateway" "nat_gateway_b" {
#  allocation_id = aws_eip.nat_gateway_eip_b.id
#  subnet_id     = aws_subnet.public_subnet.id 
#  tags = {
#    Name = "example-nat-gateway"
#  }
#  #depends_on = [aws_internet_gateway.nat_gateway_b] # Ensure Internet Gateway is ready
#}
#
#

resource "aws_route_table" "rout_igw" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.IGW_id
  }

  tags = {
    Name = "example"
  }
}
resource "aws_route_table_association" "public_assoc" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.rout_igw.id
  
}

resource "aws_route_table" "rout_private" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }
  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "rout_private_assoc" {
    subnet_id = aws_subnet.private_subnet.id
    route_table_id = aws_route_table.rout_private.id
}


