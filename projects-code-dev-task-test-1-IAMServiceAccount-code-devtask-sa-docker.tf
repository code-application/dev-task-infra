resource "google_service_account" "code_devtask_sa_docker" {
  account_id   = "code-devtask-sa-docker"
  display_name = "code-devtask-sa-docker"
  project      = var.project
}
# terraform import google_service_account.code_devtask_sa_docker projects/code-dev-task-test-1/serviceAccounts/code-devtask-sa-docker@code-dev-task-test-1.iam.gserviceaccount.com

resource "google_project_iam_binding" "name" {
  project = var.project
  role    = "${element(var.sample_app_roles, count.index)}"

  members = [
    "user:jane@example.com", // 
  ]
}

variable "sample_app_roles" {
  default = [
    "roles/cloudsql.client",
    "roles/storage.objectViewer",
    "roles/bigquery.user",
    "..."
  ]
}