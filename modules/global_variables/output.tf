data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = "us-east-1"
}

output "aws_profile" {
  value = var.environment
}

output "source_bucket" {
  value = "cloud-burger-artifacts"
}

