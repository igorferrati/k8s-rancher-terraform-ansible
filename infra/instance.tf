locals {
  nodes = {
    node-01 = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone01
    }
    node-02 = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone02
    }
    node-03 = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone03
    }
    rancher = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone01
    }
  }
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
