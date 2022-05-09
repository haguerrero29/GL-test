data "template_file" "user_data" {
  template = filebase64("./modules/computing/instalation.sh")
}

resource "aws_launch_template" "gl_timeoff_as_template" {
  name_prefix             = "gl-timeoff-as-template"
  image_id                = "ami-09d29f8bc98e7dbf4"
  //vpc_security_group_ids  = var.security_groups
  instance_type           = "t2.micro"
  key_name                = "bastion-pass"
  user_data               = "${data.template_file.user_data.rendered}"
  network_interfaces {
    associate_public_ip_address   = "true"
    security_groups = var.security_groups
  }

}

resource "aws_autoscaling_group" "gl_timeoff_asg" {
  desired_capacity      = 1
  max_size              = 2
  min_size              = 1
  vpc_zone_identifier   = var.public_subnets
  name                  = "GL-TimeOff-ASG"

  launch_template {
    id      = aws_launch_template.gl_timeoff_as_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "gl_timeoff_as_att" {
  autoscaling_group_name     = aws_autoscaling_group.gl_timeoff_asg.id
  alb_target_group_arn       = var.target_group_arn
}