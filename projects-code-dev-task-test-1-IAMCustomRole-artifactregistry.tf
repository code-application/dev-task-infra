resource "google_iam_custom_role" "artifactregistry" {
  description = "作成日: 2024-02-24、ベース: Artifact Registry 書き込み"
  permissions = ["artifactregistry.aptartifacts.create", "artifactregistry.dockerimages.get", "artifactregistry.dockerimages.list", "artifactregistry.files.download", "artifactregistry.files.get", "artifactregistry.files.list", "artifactregistry.kfpartifacts.create", "artifactregistry.locations.get", "artifactregistry.locations.list", "artifactregistry.mavenartifacts.get", "artifactregistry.mavenartifacts.list", "artifactregistry.npmpackages.get", "artifactregistry.npmpackages.list", "artifactregistry.packages.get", "artifactregistry.packages.list", "artifactregistry.projectsettings.get", "artifactregistry.pythonpackages.get", "artifactregistry.pythonpackages.list", "artifactregistry.repositories.downloadArtifacts", "artifactregistry.repositories.get", "artifactregistry.repositories.list", "artifactregistry.repositories.listEffectiveTags", "artifactregistry.repositories.listTagBindings", "artifactregistry.repositories.readViaVirtualRepository", "artifactregistry.repositories.uploadArtifacts", "artifactregistry.tags.create", "artifactregistry.tags.get", "artifactregistry.tags.list", "artifactregistry.tags.update", "artifactregistry.versions.get", "artifactregistry.versions.list", "artifactregistry.yumartifacts.create"]
  project     = var.project
  role_id     = "ArtifactRegistry"
  title       = "カスタムの Artifact Registry 書き込み"
}
# terraform import google_iam_custom_role.artifactregistry code-dev-task-test-1##ArtifactRegistry

resource "google_project_iam_binding" "name" {
  project = var.project
  role    = "roles/artifactregistry"

  members = [
    "user:jane@example.com", // 
  ]
}