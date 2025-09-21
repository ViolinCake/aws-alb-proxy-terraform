module "network" {
  source = "./vpc"
  subnet_a = module.cluster1.public_subnet
  subnet_b = module.cluster2.public_subnet
}
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
module "securityGroups" {
  source = "./SG"
  vpc_id = module.network.vpc_id
}
module "cluster1" {
  source = "./cluster"
  vpc_id = module.network.vpc_id
  public-subnet-cidr  = "10.0.0.0/24"
  private-subnet-cidr = "10.0.1.0/24"
  AZ = "us-east-1a"
  IGW_id = module.network.IGW_id
  SG_nginx_id   = module.securityGroups.SG_nginx_id
  SG_appache_id = module.securityGroups.SG_appache_id
  
}
module "cluster2" {
  source = "./cluster"
  vpc_id = module.network.vpc_id
  public-subnet-cidr  = "10.0.2.0/24"
  private-subnet-cidr = "10.0.3.0/24"
  AZ = "us-east-1b"
  IGW_id = module.network.IGW_id
  SG_nginx_id   = module.securityGroups.SG_nginx_id
  SG_appache_id = module.securityGroups.SG_appache_id

}
module "publicBalancer" {
  source = "./loadBalancing"
  name = "public-alb"
  targetName-a = "public-target-a"
  targetName-b = "public-target-b"

  internal = false
  vpc-cidr = module.network.vpc_id
  instance_id_zone_a = module.cluster1.public_ec2_id
  instance_id_zone_b = module.cluster2.public_ec2_id
  subnet_a = module.cluster1.public_subnet
  subnet_b = module.cluster2.public_subnet
  alb_sg = module.securityGroups.public_alb_sg

}
module "privateBalancer" {
  source = "./loadBalancing"
  name = "private-alb"
  targetName-a = "private-target-c"
  targetName-b = "private-target-d"

  internal = true
  vpc-cidr = module.network.vpc_id
  instance_id_zone_a = module.cluster1.private_ec2_id
  instance_id_zone_b = module.cluster2.private_ec2_id
  subnet_a = module.cluster1.private_subnet
  subnet_b = module.cluster2.private_subnet
  alb_sg = module.securityGroups.private_alb_sg

}

