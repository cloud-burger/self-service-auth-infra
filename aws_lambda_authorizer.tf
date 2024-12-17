module "lambda_authorizer" {
  source             = "./modules/lambda"
  name               = "${var.project}-authorizer"
  lambda_role        = aws_iam_role.lambda_role.arn
  handler            = "src/cmd/functions/authorizer/index.handler"
  source_bucket      = module.global_variables.source_bucket
  source_key         = "authorizer.zip"
  project            = var.project
  subnet_ids         = []
  security_group_ids = []
  source_code_hash   = base64encode(sha256("${var.commit_hash}"))

  environment_variables = {
    DATABASE_USERNAME           = data.aws_ssm_parameter.database_username.value
    DATABASE_NAME               = data.aws_ssm_parameter.database_name.value
    DATABASE_PASSWORD           = data.aws_ssm_parameter.database_password.value
    DATABASE_PORT               = data.aws_ssm_parameter.database_port.value
    DATABASE_HOST               = data.aws_ssm_parameter.database_host.value
    DATABASE_CONNECTION_TIMEOUT = 120
  }
}
