resource "aws_subnet" "main" {
  vpc_id     = data.aws_vpc.av.id
  cidr_block = "172.31.120.0/20"

  tags = {
    Name = "add-subnet"
  }
}

