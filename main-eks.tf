provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
  vpc_name = var.vpc_name
  subnet1_cidrblock = var.subnet1_cidrblock
  subnet2_cidrblock = var.subnet2_cidrblock
  az1_availabilityzone = var.az1_availabilityzone
  az2_availabilityzone = var.az2_availabilityzone
  subnet1_name = var.subnet1_name
  subnet2_name = var.subnet2_name
  igw_name = var.igw_name
  public_route_name = var.public_route_name
  securitygroup_name = var.securitygroup_name
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  securitygroup_id = module.vpc.securitygroup_id
  instance_type = var.instance_type
  subnet1_id = module.vpc.subnet1_id
  keypair = var.keypair
  instance_name = var.instance_name

}

module "eks" {
  source            = "./modules/eks"
  clusterrole_name  = var.clusterrole_name
  cluster_name      = var.cluster_name
  noderole_name     = var.noderole_name
  node_name         = var.node_name
  subnet_1_id       = module.vpc.subnet1_id
  subnet_2_id       = module.vpc.subnet2_id
  securitygroup_id = module.vpc.securitygroup_id 
  keypair_name      = module.ec2.keypair_name
}