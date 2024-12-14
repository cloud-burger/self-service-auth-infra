module "lambda_authenticate" {
  source             = "./modules/lambda"
  name               = "${var.project}-authenticate"
  lambda_role        = aws_iam_role.lambda_role.arn
  handler            = "src/cmd/function/authenticate/index.handler"
  source_bucket      = module.global_variables.source_bucket
  source_key         = "authenticate.zip"
  project            = var.project
  subnet_ids         = [local.aws_private_subnet_id]
  security_group_ids = [aws_security_group.lambda_auth_sg.id]
  source_code_hash   = base64encode(sha256("${var.commit_hash}"))
}
