variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_retention_days" {
  description = "Number of days to retain images"
  type        = number
  default     = 30
}