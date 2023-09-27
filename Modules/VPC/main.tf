
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}



output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "igw_id" {
  value =  aws_internet_gateway.igw.id
}