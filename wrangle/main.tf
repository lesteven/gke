
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


resource "google_compute_firewall" "db" {
  name = "db"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "tcp"
    ports = ["5432"]
  }
  source_tags = ["postgres"]
}

resource "google_compute_router" "router" {
  name = "router"
  network = "${google_compute_network.vpc.name}"
  region = "us-west2"
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name = "nat"
  router = "${google_compute_router.router.name}"
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
