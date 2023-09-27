
variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
}

variable "instance_type" {
  description = "The EC2 instance type."
}

variable "instance_count" {
  type = number
  default = 1
}

variable "instance_name" {
  description = "The name of the EC2 instance."
}

variable "subnet_ids" {
  type = map(string)
}





