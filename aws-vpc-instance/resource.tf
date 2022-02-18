resource "aws_vpc" "av" {
  cidr_block = var.VPC_CIDR_BLOCK
  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-vpc"
  }
}

resource "aws_subnet" "as" {
  vpc_id                  = aws_vpc.av.id
  cidr_block              = var.SUBNET_CIDR_BLOCK
  map_public_ip_on_launch = true
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

resource "aws_route_table" "art" {
  vpc_id = aws_vpc.av.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aig.id
  }

  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-art"
  }
}

resource "aws_route_table_association" "arta" {
  subnet_id      = aws_subnet.as.id
  route_table_id = aws_route_table.art.id
}


resource "aws_key_pair" "akp" {
  key_name   = "${var.PROJECT}-${var.ENVIRONMENT}-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDljY/Y83aWc2eRJP+Anwsio+IlHqqSD9sKqT9QBc6JDOKtltmh64DKWI9huVfhUwQtGkoMQnaWT+MUkI9J2DW30XhYOTpwRQtZKaGaJHomuGRNm2XXWdwTeWOG/aczDLCqRi/hU0yRkcHTAkZgCoGt1pB3NWqJv2huix5/t/ENkBNdeN0rhxPVzJVV/aht/G7L4YVf84aruc0oPoEOjTOxAWsatOQx61ZikmsB3VG6YtiPPjMjxt2ik7J/o5e0LVhbka0hrXXY/GW5+YrHBjCh8VmQxuXoCwoM8OEGspiQ8kpEP1++DKpUWBpq1euxAF22Td8sF06SRA4jHRWZy2POlwDBpHPUh8tqApfbt3j3zBcoZTMRzcxoP5DzLYOt/c3OrfUobcFyo60yOXbNPg9C2zcSOmb73KXtm6f42Mpq629rm3ICzd+eA0TwVfI3xzPuiAn6j0/aGOQpkv1Tsh+tJp9iha2RHK4UbJR0AKxUxrtl6YAxgEnYbycMODm6KZ0= dodo@dodo-xps-13-9360"
}


resource "aws_security_group" "asg" {
  name        = "${var.PROJECT}-${var.ENVIRONMENT}-asg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.av.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.PROJECT}-security-group"
  }
}


resource "aws_instance" "web" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.akp.key_name
  vpc_security_group_ids = [aws_security_group.asg.id]
  subnet_id              = aws_subnet.as.id
  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-instance"
  }
}
