resource "aws_api_gateway_rest_api" "main" {
  name = "${var.project}-main-${var.environment}"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  lifecycle {
    ignore_changes = [
      policy
    ]
  }
}

resource "aws_api_gateway_stage" "main_stage" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.main.id
  stage_name    = var.environment
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_rest_api.main]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_authorizer" "main" {
  name                   = "${var.project}-main-${var.environment}"
  rest_api_id            = aws_api_gateway_rest_api.main.id
  authorizer_uri         = module.lambda_authorizer.invoke_arn
  authorizer_credentials = aws_iam_role.invocation_role.arn
}
