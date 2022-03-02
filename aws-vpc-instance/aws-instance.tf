data "template_file" "tf" {
  template = file("script/main.sh")
}


resource "aws_instance" "ai" {
  ami                    = var.AMI
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.akp.key_name
  vpc_security_group_ids = [aws_security_group.asg.id]
  subnet_id              = aws_subnet.as.id
  user_data              = data.template_file.tf.rendered
  tags = {
    Name = "${var.PROJECT}-${var.ENVIRONMENT}-instance"
  }
}