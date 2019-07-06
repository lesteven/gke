
provider "google" {
  credentials = "${var.json}"
  project = "${var.project}"
  region = "us-west2"
}

resource "google_compute_network" "vpc" {
  name = "nut-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "nut_fw" {
  name = "nut-fw"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}
