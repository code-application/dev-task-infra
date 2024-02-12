resource "google_artifact_registry_repository" "registry" {
  location      = var.region
  repository_id = var.repository_id
  description   = "CODE Docker Artifact Registry Repository"
  format        = "DOCKER"
}