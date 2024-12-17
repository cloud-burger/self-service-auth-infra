module "global_variables" {
  source      = "./modules/global_variables"
  environment = var.environment
}

provider "aws" {
  region = module.global_variables.aws_region
}

terraform {
  backend "s3" {
    bucket = "cloud-burger-states"
    key    = "prod/lambdas.tfstate"
    region = "us-east-1"
  }
}
