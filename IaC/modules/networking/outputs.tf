output "gl_timeoff_vpc_id" {
  value = aws_vpc.gl_timeoff_vpc.id
}

output "vpc_subnets_id" {
  value = [aws_subnet.gl_timeoff_pu_subnet_1.id,aws_subnet.gl_timeoff_pu_subnet_2.id]
}

output "gl_timeoff_http_sg" {
  value = aws_security_group.gl_timeoff_http_sg.id
}

output "gl_timeoff_subnet1_id" {
  value = aws_subnet.gl_timeoff_pu_subnet_1.id
}

output "gl_timeoff_subnet2_id" {
  value = aws_subnet.gl_timeoff_pu_subnet_2.id
}