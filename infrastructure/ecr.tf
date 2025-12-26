# infrastructure/ecr.tf

# Define the list of services we need repositories for
locals {
  services = ["ai-service", "product-service", "frontend"]
}

module "ecr" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 2.0"

  for_each = toset(local.services)

  repository_name = "${local.name}-${each.key}"

  # Security: Scan images for vulnerabilities when they are pushed
  repository_image_scan_on_push = true
  
  # FinOps: Lifecycle Policy to keep costs low
  # This automatically deletes untagged images after 1 day
  # and keeps only the last 10 tagged images.
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 10 images",
        selection    = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 10
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  tags = local.tags
}