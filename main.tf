module "global_variables" {
  source      = "./modules/global_variables"
  environment = var.environment
}

data "terraform_remote_state" "eks_state" {
  backend = "s3"
  config = {
    bucket = "cloud-burger-state"
    key    = "prod/eks.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "database_state" {
  backend = "s3"

  config = {
    bucket = "cloud-burger-state"
    key    = "prod/database.tfstate"
    region = "us-east-2"
  }
}

locals {
  aws_vpc_id            = data.terraform_remote_state.database_state.outputs.vpc_id
  aws_private_subnet_id = data.terraform_remote_state.database_state.outputs.private_subnet_id
  aws_rds_public_sg_id  = data.terraform_remote_state.database_state.outputs.rds_public_sg_id
  eks_cluster_endpoint  = data.terraform_remote_state.eks_state.outputs.eks_cluster_endpoint
}

provider "aws" {
  region = module.global_variables.aws_region
}

terraform {
  backend "s3" {
    bucket = "cloud-burger-state"
    key    = "prod/lambdas.tfstate"
    region = "us-east-2"
  }
}
