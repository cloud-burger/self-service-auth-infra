resource "aws_ssm_parameter" "jwt_secret" {
  name  = "/${var.project}/jwt_secret"
  value = var.jwt_secret
  type  = "SecureString"
}
