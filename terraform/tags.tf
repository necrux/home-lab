locals {
  default_tags = {
    ManagedBy   = "Terraform"
    Environment = "Home Lab"
    Owner       = "necrux"
  }

  tags = merge(local.default_tags, var.tags)
}