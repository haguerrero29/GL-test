terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "networking" {
  source                = "./modules/networking"
  region                = var.region
  vpc_cidr_block        = var.vpc_cidr_block
  gl_timeoff_pu_cidr    = var.gl_timeoff_pu_cidr
  gl_timeoff_pu2_cidr   = var.gl_timeoff_pu2_cidr
}

module "computing" {
  source              = "./modules/computing"
  vpc_subnets_id      = module.networking.gl_timeoff_vpc_id
  gl_timeoff_http_sg  = module.networking.gl_timeoff_http_sg
}

module "balancing" {
  source            = "./modules/balancing"
  vpc_id            = module.networking.gl_timeoff_vpc_id
  vpc_subnets_id    = module.networking.vpc_subnets_id
  security_group    = module.networking.gl_timeoff_http_sg
  server_id         = module.computing.server_id
}