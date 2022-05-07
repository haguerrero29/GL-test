data "template_file" "user_data" {
  template = file("./modules/computing/instalation.sh")
}

resource "aws_instance" "gl_timeoff_server" {
  ami               = "ami-09d56f8956ab235b3"
  instance_type     = "t2.micro"
  key_name          = "bastion-pass"
  security_groups   = [var.gl_timeoff_http_sg]
  subnet_id         = var.vpc_subnets_id

  user_data = "${data.template_file.user_data.rendered}"

  associate_public_ip_address = true

  tags = {
    Name = "GL-TimeOff-Server"
  }
}