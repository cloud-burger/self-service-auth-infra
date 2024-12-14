resource "aws_security_group" "lambda_auth_sg" {
  name   = "lambda_auth_sg"
  vpc_id = local.aws_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "lambda_to_rds" {
  type                     = "ingress"
  from_port                = 5432 # Porta do banco de dados na instância RDS
  to_port                  = 5432 # Porta do banco de dados na instância RDS
  protocol                 = "tcp"
  security_group_id        = local.aws_rds_public_sg_id           # ID da security group da RDS
  source_security_group_id = aws_security_group.lambda_auth_sg.id # ID da security group da Lambda
}
