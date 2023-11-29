terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../keys/project_key.json")
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}
