variable "vpc-cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "instance_id_zone_a" {
  description = "reusable instance id"
  type = string
  default = "null"

}
variable "instance_id_zone_b" {
  description = "reusable instance id"
  type = string
  default = "null"

}
variable "subnet_a" {
  description = "subnet in az_a"
  type = string
  default = "10.0.0.0/24"
}
variable "subnet_b" {
  description = "subnet in az_b"
  type = string
  default = "10.0.2.0/24"
}
variable "alb_sg" {
  description = "load balancer security group"
  type = string
  default = "null"
}
# variable "private_alb_sg" {
#   description = "private load balancer security group"
#   type = string
#   default = "null"
# }
variable "alb_arn" {
  description = "load balancer security group"
  type = string
  default = "null"
}
variable "tg_a_arn" {
  description = "arn of target group a"
  type        = string
  default     = "null"
}
variable "tg_b_arn" {
  description = "arn of target group b"
  type        = string
  default     = "null"
}
variable "name" {
  description = "load balancer unique name"
  type = string
  default = "null"
}
variable "internal" {
  description = "stating the load balancer internal true or false"
  type = bool
  default = false
}
variable "targetName-a" {
  description = "naming target groups"
  type = string
  default = "null"
}
variable "targetName-b" {
  description = "naming target groups"
  type = string
  default = "null"
}
# variable "targetName-b" {
#   description = "naming target groups attachmenets"
#   type = string
#   default = "null"
# }