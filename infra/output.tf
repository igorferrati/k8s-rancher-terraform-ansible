output "internal_ip" {
  value = google_compute_instance.vm[*].network_interface[*].network_ip
}

output "external_ip" {
  value = google_compute_instance.vm[*].network_interface[*].access_config[*].nat_ip
}

output "vm_name" {
  value = google_compute_instance.vm[*].name
}