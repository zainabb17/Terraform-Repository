resource "aws_ecr_repository" "ecr_repository" {
  name = var.repository_name

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle_policy" {
  repository = aws_ecr_repository.ecr_repository.name
  policy = jsonencode({
    rules = [
      {
        rulePriority = 10,
        description  = "Remove old images",
        selection = {
          tagStatus   = "any",
          countType   = "sinceImagePushed",
          countNumber = var.image_retention_days
        },
        action = {
          type = "expire"
        }
      },
    ]
  })
}


output "repository_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}