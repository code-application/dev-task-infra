locals {
  service_account_prefix = "devtask-sa"
}

# TerraformのServiceAccountはTerraform実行前、つまり手動で作成する必要があるので、以下のリソースと同じ名前で作成し、後でTerraformにインポートする
resource "google_service_account" "code_devtask_sa_tf" {
  account_id   = "${local.service_account_prefix}-tf"
  display_name = "${local.service_account_prefix}-tf"
  project      = var.project
  description  = "TerraformがGCPリソースを作成する際に使用する"
}
# terraform import google_service_account.code_devtask_sa_tf code-dev-task-tf

resource "google_service_account" "code_devtask_sa_docker" {
  account_id   = "${local.service_account_prefix}-docker"
  display_name = "${local.service_account_prefix}-docker"
  project      = var.project
  description  = "Artifact Registryにローカルからログインする際に使用する"
}

resource "google_service_account" "devtask_sa_cloudrun" {
  account_id   = "${local.service_account_prefix}-cloudrun"
  description  = "Cloud Run用"
  display_name = "${local.service_account_prefix}-cloudrun"
  project      = var.project
  #   account_id   = "devtask-sa-cloudrun"
}
# terraform import google_service_account.devtask_sa_cloudrun devtask-sa-cloudrun

resource "google_service_account" "devtask_sa_githubactions" {
  account_id   = "${local.service_account_prefix}-githubactions"
  display_name = "${local.service_account_prefix}-githubactions"
  project      = var.project
  description  = "GitHub ActionsがGCPリソースを操作する際に使用する"
  #   account_id   = "devtask-sa-githubactions"
}
# terraform import google_service_account.devtask_sa_githubactions devtask-sa-githubactions

# resource "google_service_account" "devtask_sa_tfstate" {
#   account_id   = "${local.service_account_prefix}-tfstate"
#   description  = "Terraform State用サービスアカウント"
#   display_name = "${local.service_account_prefix}-tfstate"
#   project      = var.project
# }