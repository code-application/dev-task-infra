resource "google_cloud_run_service" "code-devtask-api-run" {
  autogenerate_revision_name = false
  location                   = var.region
  name                       = "code-devtask-api-run"
  project                    = var.project

  template {
    spec {
      container_concurrency = 80
      service_account_name  = "${var.project_number}-compute@developer.gserviceaccount.com"
      timeout_seconds       = 300

      containers {
        args    = []
        command = []
        image   = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.registry.name}/code-devtask-api:v0.0.2"

        ports {
          container_port = 8080
          name           = "http1"
        }

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "512Mi"
          }
          requests = {}
        }
      }
    }
  }

  traffic {
    latest_revision = true
    percent         = 100
  }

  lifecycle {
    ignore_changes = [
      template[0].spec[0].containers[0].image,
    ]
  }
}
