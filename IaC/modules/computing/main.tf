resource "aws_instance" "gl_timeoff_server" {
  ami               = "ami-0cb4e786f15603b0d"
  instance_type     = "t2.micro"
  key_name          = "bastion-pass"
  security_groups   = [var.gl_timeoff_http_sg]
  subnet_id         = var.vpc_subnets_id

  user_data = file("./modules/computing/instalation.sh")

  associate_public_ip_address = true

  tags = {
    Name = "GL-TimeOff-Server"
  }
}