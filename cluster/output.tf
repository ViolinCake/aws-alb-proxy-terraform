output "public_ec2_id" {
  value = aws_instance.public_ec2.id
}
output "private_ec2_id" {
  value = aws_instance.private_ec2.id
}
output "public_subnet" {
  value = aws_subnet.public_subnet.id
}
output "private_subnet" {
  value = aws_subnet.private_subnet.id
}
