module "global_variables" {
  source      = "./modules/global_variables"
  environment = var.environment
}

provider "aws" {
  region = module.global_variables.aws_region
}

data "terraform_remote_state" "customers_state" {
  backend = "s3"

  config = {
    bucket = "cloud-burger-states"
    key    = "prod/customers/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "iac_state" {
  backend = "s3"

  config = {
    bucket = "cloud-burger-states"
    key    = "prod/iac.tfstate"
    region = "us-east-1"
  }
}

locals {
  aws_vpc_id                   = data.terraform_remote_state.iac_state.outputs.vpc_id
  aws_private_subnets          = data.terraform_remote_state.iac_state.outputs.private_subnets
  aws_dynamodb_table_customers = data.terraform_remote_state.customers_state.outputs.aws_dynamodb_table_customers
}

terraform {
  backend "s3" {
    bucket = "cloud-burger-states"
    key    = "prod/lambdas.tfstate"
    region = "us-east-1"
  }
}

data "aws_lb" "loadbalancer" {
  tags = {
    "service.k8s.aws/stack" = "istio-ingress/istio-ingress",
  }
}
