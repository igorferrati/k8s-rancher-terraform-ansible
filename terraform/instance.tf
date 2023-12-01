locals {
  nodes = {
    node-01 = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone01
      boot_disk_size = var.boot_disk_size_nodes
    }
    node-02 = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone02
      boot_disk_size = var.boot_disk_size_nodes
    }
    node-03 = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone03
      boot_disk_size = var.boot_disk_size_nodes
    }
    rancher = {
      machine_type = var.instance_type
      instance_zone = var.instance_zone01
      boot_disk_size = var.boot_disk_size_rancher
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
      size  = each.value.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

}
