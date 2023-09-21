terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

locals {
  nodes = {
    node-01 = {
      machine_type = var.instance_type
      instance_zone    = var.instance_zone01
    }
    node-02 = {
      machine_type = var.instance_type
      instance_zone    = var.instance_zone02
    }
    node-03 = {
      machine_type = var.instance_type
      instance_zone    = var.instance_zone03
    }
    rancher = {
      machine_type = var.instance_type
      instance_zone    = var.instance_zone01
    }

  }
}

provider "google" {
  credentials = file("../key.json")
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_compute_firewall" "web" {
  name = "web-access"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm-ubuntu" {
  for_each = local.nodes

  name         = each.key
  machine_type = each.value.machine_type
  zone = each.value.instance_zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"
    access_config {

    }
  }

}

output "external_ips" {
  value = {
    for instance in google_compute_instance.vm-ubuntu :
    instance.name => instance.network_interface[0].access_config[0].nat_ip
  }
}
