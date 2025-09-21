output "SG_nginx_id" {
  value = aws_security_group.nginx.id
}
output "SG_appache_id" {
  value = aws_security_group.appache.id
}
output "public_alb_sg" {
  value = aws_security_group.public_alb_sg.id
}
output "private_alb_sg" {
  value = aws_security_group.private_alb_sg.id
}