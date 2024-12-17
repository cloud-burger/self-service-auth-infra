resource "aws_api_gateway_rest_api" "main" {
  name = "${var.project}-main-${var.environment}"

  body = templatefile("${path.module}/openapi.yaml", {
    load_balancer_uri = local.eks_cluster_endpoint,
    authorizer_uri = module.lambda_authorizer.invoke_arn,
    authorizer_credentials = aws_iam_role.invocation_role.arn,
    provider_arn = aws_cognito_user_pool.main.arn,
    vpc_link_id = aws_api_gateway_vpc_link.main_vpc_link.id
  })

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
    redeployment = sha1(jsonencode([aws_api_gateway_rest_api.main.body]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_vpc_link" "main_vpc_link" {
  name = "k8s-vpc-link"

  target_arns = [
    "arn:aws:elasticloadbalancing:us-east-1:594646746001:loadbalancer/net/k8s-istioing-istioing-1be9021431/bcafb1d95314b38a"
  ]
}
