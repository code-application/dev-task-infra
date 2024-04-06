# Overall
variable "project" {

}

variable "project_number" {

}
variable "credentials_file" {

}

variable "region" {
  default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}

# Artifact Registry
variable "repository_id" {
  default     = ""
  description = "Docker registry ID"
}