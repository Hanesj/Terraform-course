locals {
  project = "14-modules"
  common_tags = {
    Project    = local.project
    Managed_By = "Terraform"
  }
}