resource "aws_instance" "ec2_instance" {
    ami = var.ami
    security_groups = [var.securitygroup_id]
    instance_type = var.instance_type
    subnet_id = var.subnet1_id
    key_name = var.keypair

    tags = {
      Name=var.instance_name
    }
  
}