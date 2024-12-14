resource "aws_api_gateway_method" "main" {
  rest_api_id          = var.rest_api_id
  resource_id          = var.resource_id
  http_method          = var.http_method
  api_key_required     = var.api_key_required
  authorization        = var.authorization
  authorizer_id        = var.authorizer_id
  request_parameters   = var.request_parameters
  authorization_scopes = var.authorization_scopes
}

resource "aws_api_gateway_integration" "main" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.main.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_arn}/invocations"
}

data "aws_caller_identity" "current" {}

resource "aws_lambda_permission" "main" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${var.rest_api_id}/*/${var.path == "" ? "*" : "${aws_api_gateway_method.main.http_method}${var.path}"}"
}
