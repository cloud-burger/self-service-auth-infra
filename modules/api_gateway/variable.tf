variable "account_id" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "rest_api_id" {
  type = string
}

variable "resource_id" {
  type = string
}

variable "http_method" {
  type = string
}

variable "lambda_arn" {
  type = string
}

variable "authorization" {
  type    = string
  default = "NONE"
}

variable "authorization_scopes" {
  type    = list(any)
  default = []
}

variable "authorizer_id" {
  type    = string
  default = ""
}

variable "request_parameters" {
  default = {}
}

variable "api_key_required" {
  type    = string
  default = "false"
}

variable "path" {
  type    = string
  default = ""
}
