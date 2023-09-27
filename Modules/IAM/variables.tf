
variable "users" {
  description = "Map of user names to policy ARNs"
  type = map(string)
  default = {
    developer   = "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    qa          = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess",
    production  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
}