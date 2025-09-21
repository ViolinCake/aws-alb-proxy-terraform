resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id
    tags = {
      name = "Internet-Gateway"
    }
  
}

# resource "aws_eip" "nat_gateway_eip_a" {
#   domain = "vpc"
#   tags = {
#     Name = "nat-gateway-eip"
#   }
# }
# resource "aws_nat_gateway" "nat_gateway_a" {
#   allocation_id = aws_eip.nat_gateway_eip_a.id
#   subnet_id     = var.subnet_a # Replace with your public subnet ID
#   tags = {
#     Name = "example-nat-gateway"
#   }
#   #depends_on = [aws_internet_gateway.nat_gateway_a] # Ensure Internet Gateway is ready
# }




# resource "aws_eip" "nat_gateway_eip_b" {
#   domain = "vpc"
#   tags = {
#     Name = "nat-gateway-eip"
#   }
# }
# resource "aws_nat_gateway" "nat_gateway_b" {
#   allocation_id = aws_eip.nat_gateway_eip_b.id
#   subnet_id     = var.subnet_b # Replace with your public subnet ID
#   tags = {
#     Name = "example-nat-gateway"
#   }
#   #depends_on = [aws_internet_gateway.nat_gateway_b] # Ensure Internet Gateway is ready
# }