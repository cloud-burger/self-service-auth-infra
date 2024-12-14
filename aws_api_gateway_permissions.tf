data "aws_iam_policy_document" "main_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = ["*"]
  }
}

resource "aws_api_gateway_rest_api_policy" "main_policy" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  policy      = data.aws_iam_policy_document.main_policy_document.json
}
