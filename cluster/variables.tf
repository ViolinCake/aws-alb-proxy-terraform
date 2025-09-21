variable "vpc_id" {
  type = string
  default = "null"
}
variable "AZ" {
  type = string
  default = "us-east-1a"
}
# variable "vpc-cidr" {
#   description = "The CIDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }
variable "public-subnet-cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"

}
variable "private-subnet-cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.1.0/24"

}
variable "key_name" {
  description = "key usd by my account"
  type        = string
  default     = "mykey"

}
variable "aws_ami" {
  type = string
  default = "08982f1c5bf93d976"
}
variable "SG_nginx_id" {
  type = string
  default = "null"

}
variable "SG_appache_id" {
  type = string
  default = "null"

}
variable "IGW_id" {
  type = string
  default = "null"
}
variable "nat_a" {
  type = string
  default = "null"
}
variable "nat_b" {
  type = string
  default = "null"
}