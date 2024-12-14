resource "aws_cloudwatch_log_group" "authorizer_log_group" {
  name              = "/aws/lambda/${module.lambda_authorizer.function_name}"
  retention_in_days = 5
}

resource "aws_cloudwatch_log_group" "authenticate_log_group" {
  name              = "/aws/lambda/${module.lambda_authenticate.function_name}"
  retention_in_days = 5
}
