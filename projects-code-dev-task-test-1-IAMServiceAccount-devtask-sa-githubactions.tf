resource "google_service_account" "devtask_sa_githubactions" {
  account_id   = "devtask-sa-githubactions"
  display_name = "devtask-sa-githubactions"
  project      = var.project
}
# terraform import google_service_account.devtask_sa_githubactions projects/code-dev-task-test-1/serviceAccounts/devtask-sa-githubactions@code-dev-task-test-1.iam.gserviceaccount.com

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