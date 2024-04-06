resource "google_service_account" "devtask_sa_cloudrun" {
  account_id   = "devtask-sa-cloudrun"
  description  = "Cloud Run用"
  display_name = "devtask-sa-cloudrun"
  project      = var.project
}
# terraform import google_service_account.devtask_sa_cloudrun projects/code-dev-task-test-1/serviceAccounts/devtask-sa-cloudrun@code-dev-task-test-1.iam.gserviceaccount.com

resource "google_project_iam_binding" "name" {
  project = var.project
  role    = "${element(var.sample_app_roles, count.index)}"

  members = [
    "user:jane@example.com", // serviceaccount
  ]
}


variable "sample_app_roles" {
  default = [
    "roles/artifactregistry",
    "roles/cloudrun",
  ]
}