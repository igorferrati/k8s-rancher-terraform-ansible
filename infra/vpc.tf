resource "google_compute_firewall" "web" {
  name = "web-access"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}
