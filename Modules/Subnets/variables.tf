variable "vpc_id" {
    description = "vpc id"

}

variable "igw_id" {
  description = "igw id"
}

variable "public_subnets" {
  type = map(string)
  default = {
    "us-east-1a" = "10.0.1.0/24"
    "us-east-1b" = "10.0.2.0/24"
  }
}

variable "private_subnets" {
  type = map(string)
  default = {
    "us-east-1a" = "10.0.100.0/24"
    "us-east-1b" = "10.0.101.0/24"
  }
}

variable "availability_zones" {
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b"]
}

variable "subnet_id" {
  description = "List of subnet IDs to associate with the ALB"
  type        = map(string)
}