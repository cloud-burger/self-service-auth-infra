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

  depends_on = [
    module.method_authorizer
  ]

  triggers = {
    redeployment = sha1(jsonencode([module.method_authorizer]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_resource" "authorizer" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "authorizer"
}

module "method_authorizer" {
  source        = "./modules/api_gateway"
  account_id    = module.global_variables.account_id
  aws_region    = module.global_variables.aws_region
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.authorizer.id
  http_method   = "GET"
  lambda_arn    = module.lambda_authorizer.invoke_arn
  authorization = "NONE"
}
