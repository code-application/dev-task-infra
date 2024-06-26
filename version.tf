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
    bucket = "devtask-tf-state"
    prefix = "terraform/state"
  }
}