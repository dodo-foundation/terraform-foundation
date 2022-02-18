resource "aws_vpc" "av" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-vpc"
  }
}

resource "aws_subnet" "as" {
  vpc_id     = aws_vpc.av.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-subnet"
  }
}

resource "aws_internet_gateway" "aig" {
  vpc_id = aws_vpc.av.id

  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-aig"
  }
}