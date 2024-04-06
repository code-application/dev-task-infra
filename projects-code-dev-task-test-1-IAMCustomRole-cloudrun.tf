resource "google_iam_custom_role" "cloudrun" {
  description = "作成日: 2024-02-25、ベース: Cloud Run 管理者"
  permissions = ["recommender.locations.get", "recommender.locations.list", "recommender.runServiceCostInsights.get", "recommender.runServiceCostInsights.list", "recommender.runServiceCostInsights.update", "recommender.runServiceCostRecommendations.get", "recommender.runServiceCostRecommendations.list", "recommender.runServiceCostRecommendations.update", "recommender.runServiceIdentityInsights.get", "recommender.runServiceIdentityInsights.list", "recommender.runServiceIdentityInsights.update", "recommender.runServiceIdentityRecommendations.get", "recommender.runServiceIdentityRecommendations.list", "recommender.runServiceIdentityRecommendations.update", "recommender.runServiceSecurityInsights.get", "recommender.runServiceSecurityInsights.list", "recommender.runServiceSecurityInsights.update", "recommender.runServiceSecurityRecommendations.get", "recommender.runServiceSecurityRecommendations.list", "recommender.runServiceSecurityRecommendations.update", "resourcemanager.projects.get", "run.configurations.get", "run.configurations.list", "run.executions.delete", "run.executions.get", "run.executions.list", "run.jobs.create", "run.jobs.delete", "run.jobs.get", "run.jobs.getIamPolicy", "run.jobs.list", "run.jobs.listEffectiveTags", "run.jobs.listTagBindings", "run.jobs.run", "run.jobs.runWithOverrides", "run.jobs.update", "run.locations.list", "run.operations.delete", "run.operations.get", "run.operations.list", "run.revisions.delete", "run.revisions.get", "run.revisions.list", "run.routes.get", "run.routes.invoke", "run.routes.list", "run.services.create", "run.services.createTagBinding", "run.services.delete", "run.services.deleteTagBinding", "run.services.get", "run.services.getIamPolicy", "run.services.list", "run.services.listEffectiveTags", "run.services.listTagBindings", "run.services.setIamPolicy", "run.services.update", "run.tasks.get", "run.tasks.list"]
  project     = var.project
  role_id     = "CloudRun"
  title       = "カスタムの Cloud Run 管理者"
}
# terraform import google_iam_custom_role.cloudrun code-dev-task-test-1##CloudRun

resource "google_project_iam_binding" "name" {
  project = var.project
  role    = "roles/artifactregistry"

  members = [
    "user:jane@example.com", // 
  ]
}