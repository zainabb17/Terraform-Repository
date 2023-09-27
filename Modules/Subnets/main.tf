
resource "aws_subnet" "public_subnets" {
 for_each = toset(var.availability_zones)
 vpc_id     = var.vpc_id
 cidr_block = var.public_subnets[each.key]
 availability_zone = each.key
 map_public_ip_on_launch = true

 tags = {
   Name = "Public Subnet ${each.key}"
 }
}

resource "aws_subnet" "private_subnets" {
 for_each = toset(var.availability_zones)
 vpc_id      = var.vpc_id
 cidr_block = var.private_subnets[each.key]
 availability_zone = each.key
 
 tags = {
   Name = "Private-Subnet-${each.key}"
  
 }
}
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "public_subnet_associations" {
  for_each = aws_subnet.public_subnets
  
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

output "public_subnet_ids" {
  value = { for az, subnet in aws_subnet.public_subnets : az => subnet.id }
}

output "private_subnet_ids" {
  value = { for az, subnet in aws_subnet.private_subnets : az => subnet.id }
}
