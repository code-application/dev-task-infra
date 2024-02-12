# provider
## additional plugins for google (or other provider like AWS, Azure)
provider "google" {
  credentials = file(var.credentials_file)

  project = var.project
  region  = var.region
  zone    = var.zone
}