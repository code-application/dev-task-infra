# Terraform
## about Terraform settings
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
  backend "gcs" {
    bucket = "dev-task-tf-state-dev"
    prefix = "terraform/state"
  }
}