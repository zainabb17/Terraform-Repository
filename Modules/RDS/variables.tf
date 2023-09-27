variable "subnet_ids_map" {
  description = "List of subnet IDs for RDS"
  type        = map(string)
}

variable "instance_class" {
    description = "name of the class"
}

variable "rds_instance_id" {
  description = "Name of the RDS instance"
  type        = string
}

variable "rds_username" {
  description = "Username for the RDS instance"
  type        = string
}

variable "rds_password" {
  description = "Password for the RDS instance"
  type        = string
}