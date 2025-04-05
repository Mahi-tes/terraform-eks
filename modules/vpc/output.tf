output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "securitygroup_id" {
  value = aws_security_group.securitygroup.id
}

output "subnet1_id" {
  value = aws_subnet.public_az1_subnet.id
}

output "subnet2_id" {
  value = aws_subnet.public_az2_subnet.id
}