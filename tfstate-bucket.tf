// Terraform State用のGCSバケット
resource "google_storage_bucket" "devtask-tf-state" {
  name          = "devtask-tf-state"
  force_destroy = false
  location      = var.region
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}