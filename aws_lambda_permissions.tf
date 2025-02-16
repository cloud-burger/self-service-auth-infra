resource "aws_iam_role" "lambda_role" {
  name = "${var.project}-auth-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "sts:AssumeRole"
      ],
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "${var.project}-auth-policy-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_policy_attachment" "lambda_vpc_policy" {
  name       = "lambda_vpc_policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_policy_attachment" "lambda_cloudwatch_policy" {
  name       = "lambda_cloudwatch_policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
