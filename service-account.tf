locals {
    service_account_prefix = "devtask-sa"
}

resource "google_service_account" "code_devtask_sa_tf" {
    account_id   = "${local.service_account_prefix}-tf"
    display_name = "${local.service_account_prefix}-tf"
    project      = var.project
    description = "TerraformがGCPリソースを作成する際に使用する"
}

resource "google_service_account" "code_devtask_sa_docker" {
    account_id   = "${local.service_account_prefix}-docker"
    display_name = "${local.service_account_prefix}-docker"
    project      = var.project
    description = "Artifact Registryにローカルからログインする際に使用する"
}

resource "google_service_account" "devtask_sa_cloudrun" {
    account_id   = "${local.service_account_prefix}-cloudrun"
    description  = "Cloud Run用" // 何に使用しているか不明。不要かも？
    display_name = "${local.service_account_prefix}-cloudrun"
    project      = var.project
}

resource "google_service_account" "devtask_sa_githubactions" {
    account_id   = "${local.service_account_prefix}-githubactions"
    display_name = "${local.service_account_prefix}-githubactions"
    project      = var.project
    description = "GitHub ActionsがGCPリソースを操作する際に使用する"
}