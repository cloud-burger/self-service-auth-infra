module "lambda_authorizer" {
  source             = "./modules/lambda"
  name               = "${var.project}-authorizer"
  lambda_role        = aws_iam_role.lambda_role.arn
  handler            = "src/cmd/functions/authorizer/index.handler"
  source_bucket      = module.global_variables.source_bucket
  source_key         = "authorizer.zip"
  project            = var.project
  subnet_ids         = local.aws_private_subnets
  security_group_ids = [aws_security_group.lambda_auth_sg.id]
  source_code_hash   = base64encode(sha256("${var.commit_hash}"))

  environment_variables = {
    DADYNAMO_TABLE_CUSTOMERS = local.aws_dynamodb_table_customers
  }
}
