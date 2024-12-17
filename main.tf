module "global_variables" {
  source      = "./modules/global_variables"
  environment = var.environment
}

provider "aws" {
  region = module.global_variables.aws_region
}

<<<<<<< Updated upstream
=======
data "terraform_remote_state" "database_state" {
  backend = "s3"

  config = {
    bucket = "cloud-burger-states"
    key    = "prod/database.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "eks_state" {
  backend = "s3"

  config = {
    bucket = "cloud-burger-states"
    key    = "prod/eks.tfstate"
    region = "us-east-1"
  }
}

locals {
  aws_vpc_id          = data.terraform_remote_state.eks_state.vpc_id
  aws_private_subnets = data.terraform_remote_state.eks_state.outputs.private_subnets
  rds_public_sg_id    = data.terraform_remote_state.database_state.rds_public_sg_id
}

>>>>>>> Stashed changes
terraform {
  backend "s3" {
    bucket = "cloud-burger-states"
    key    = "prod/lambdas.tfstate"
    region = "us-east-1"
  }
}
