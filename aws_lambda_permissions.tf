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

resource "aws_iam_policy" "ssm_policy" {
  name        = "ssm_policy"
  description = "SSM Policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        Resource = "arn:aws:ssm:${var.region}:${module.global_variables.account_id}:parameter/${var.project}/*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "ssm_policy_attachment" {
  name       = "ssm_policy_attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.ssm_policy.arn
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "${var.project}-auth-policy-attachment"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

resource "aws_iam_policy_attachment" "lambda_rds_policy" {
  name       = "lambda_rds_policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
}

resource "aws_iam_policy_attachment" "lambda_vpc_policy" {
  name       = "lambda_vpc_policy"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

