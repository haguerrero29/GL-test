terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

module "networking" {
  source = "./modules/networking"
  region = var.region
  vpc_cidr_block = var.vpc_cidr_block
  gl_timeoff_pu_cidr = var.gl_timeoff_pu_cidr
}

module "balancing" {
  source = "./modules/balancing"
  vpc_id = module.networking.gl_timeoff_vpc_id
  vpc_subnets_id = module.networking.vpc_subnets_id
  security_group = module.networking.gl_timeoff_http_sg
}