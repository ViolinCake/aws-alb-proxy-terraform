output "vpc_id" {
  value = aws_vpc.main_vpc.id
}
output "IGW_id" {
  value = aws_internet_gateway.igw.id
}
# output "nat_a" {
#   value = aws_nat_gateway.nat_gateway_a.id
# }
# output "nat_b" {
#   value = aws_nat_gateway.nat_gateway_b.id
# }