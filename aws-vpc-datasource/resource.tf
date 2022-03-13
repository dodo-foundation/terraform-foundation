resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.av.id
  cidr_block = "172.31.112.0/20"

  tags = {
    Name = "add-subnet"
  }
}

resource "aws_iam_role" "air_lambda" {
  name = "${var.PROJECT}-${var.ENVIRONMENT}-lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

