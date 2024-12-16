data "aws_ssm_parameter" "database_host" {
  name = "/prod/${var.project}/database-host"
}

data "aws_ssm_parameter" "database_port" {
  name = "/prod/${var.project}/database-port"
}

data "aws_ssm_parameter" "database_name" {
  name = "/prod/${var.project}/database-name"
}

data "aws_ssm_parameter" "database_username" {
  name = "/prod/${var.project}/database-username"
}

data "aws_ssm_parameter" "database_password" {
  name = "/prod/${var.project}/database-password"
}
