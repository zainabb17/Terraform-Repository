variable "alb_name" {
  description = "Name of the ALB"
  type        = string
}

variable "alb_internal" {
  description = "Whether the ALB is internal (true) or public (false)"
  type        = bool
}

variable "subnets" {
  description = "List of subnet IDs to associate with the ALB"
  type        = map(string)
}
