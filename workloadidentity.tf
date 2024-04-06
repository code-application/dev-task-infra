resource "google_iam_workload_identity_pool" "code-devtask-workload-pool-dev" {
  workload_identity_pool_id = "code-devtask-workload-pool-dev"
  disabled                  = false
  display_name              = "code-devtask-workload-pool-dev"
  project                   = var.project
}

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_provider_id = "github"

  display_name              = "github"
  project                   = var.project_number
  workload_identity_pool_id = google_iam_workload_identity_pool.code-devtask-workload-pool-dev.workload_identity_pool_id

  disabled = false
  attribute_mapping = {
    "attribute.repository" = "assertion.repository"
    "google.subject"       = "assertion.sub"
  }
  oidc {
    allowed_audiences = []
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
}
