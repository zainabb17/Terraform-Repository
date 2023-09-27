resource "aws_instance" "ec2_instance" {
  for_each = var.subnet_ids
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = each.value

  tags = {
    Name = "Instance-in-${each.key}" 
  }
}



