output "workload_identity_provider" {
  value = google_iam_workload_identity_pool_provider.github.name
  description = "GitHub ActionsのWorkload Identity Providerに設定するプロバイダ情報"
  sensitive = true
}

output "githubactions_service_account_email" {
  value = google_service_account.devtask_sa_githubactions.email
  description = "GitHub ActionsのサービスアカウントEmail"
}

output "cloudrun_endpoint" {
  value = google_cloud_run_service.code-devtask-api-run.status[0].url
  description = "Cloud Runのエンドポイント"
}

output "artifact_registry_repository" {
  value = google_artifact_registry_repository.registry.id
  description = "Docker Registryのエンドポイント"
}