provider "google" {
    project = var.project_id
    region = var.region
    credentials = file("secret/sa.json")
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.0.0"
    }
  }

  required_version = "~> 1.0.9"

  backend "gcs" {}
}