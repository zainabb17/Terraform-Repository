
variable "vpc_id" {
  description = "vpc id"
}
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
}

variable "vpc_name" {
  default     = "MyVPC"
  description = "The name of the VPC."
}

variable "igw_id" {
  description = "internet gateway id"
}
