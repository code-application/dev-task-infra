locals {
  terraform_sa_roles = [
    "roles/editor",
    "roles/resourcemanager.projectIamAdmin",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/storage.objectAdmin",
    "roles/run.admin"
  ]
  docker_login_sa_roles = [
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountUser"
  ]

  github_actions_sa_roles = [
    "roles/iam.serviceAccountUser",
    "roles/run.admin",
    "roles/artifactregistry.writer"
  ]

  github_actions_workload_identity_principalset_roles = [
    "roles/iam.workloadIdentityUser"
  ]
}
# ===============================================
# サービスアカウントに設定するプロジェクトに対する権限
# ===============================================
# Terraform用のサービスアカウントのロール
resource "google_project_iam_member" "terraform_service_account_roles" {
  for_each = toset(local.terraform_sa_roles) # 指定したリストごとにメンバー・ロールのマッピングを行う
  project  = var.project
  member   = "serviceAccount:${google_service_account.code_devtask_sa_tf.email}"
  role     = each.value
}

# ローカルでArtifactRegistryにログインするときに権限借用で使用する
resource "google_project_iam_member" "docker_service_account_roles" {
  for_each = toset(local.docker_login_sa_roles) # 指定したリストごとにメンバー・ロールのマッピングを行う
  project  = var.project
  member   = "serviceAccount:${google_service_account.code_devtask_sa_docker.email}"
  role     = each.value
}

# GitHub ActionsからGCPのリソースを操作するときに権限借用で使用する
resource "google_project_iam_member" "github_actions_service_account_roles" {
  for_each = toset(local.github_actions_sa_roles) # 指定したリストごとにメンバー・ロールのマッピングを行う
  project  = var.project
  member   = "serviceAccount:${google_service_account.devtask_sa_githubactions.email}"
  role     = each.value
}

# GitHub ActionsでWorkload Identityを使用してアクセストークンを取得する際に使用する
resource "google_project_iam_member" "github_actions_workload_identity_principalset_roles" {
  for_each = toset(local.github_actions_workload_identity_principalset_roles) # 指定したリストごとにメンバー・ロールのマッピングを行う
  project  = var.project
  member   = "principalSet://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.code-devtask-workload-pool-dev.workload_identity_pool_id}/attribute.repository/code-application/dev-task-api"
  role     = each.value
  depends_on = [
    google_iam_workload_identity_pool.code-devtask-workload-pool-dev,
    google_iam_workload_identity_pool_provider.github
  ]
}

# ===============================================
# CloudRunにアクセスする権限を設定
# ===============================================
resource "google_cloud_run_service_iam_binding" "default" {
  location = google_cloud_run_service.code-devtask-api-run.location
  service  = google_cloud_run_service.code-devtask-api-run.name
  role     = "roles/run.invoker"
  members = [
    "allUsers" # インターネットからアクセスするため、全ユーザーを許可する
  ]
}


