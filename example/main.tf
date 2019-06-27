
provider "google" {
  credentials = "${var.json}"
  project = "${var.project}"
  region = "us-west2"
  zone = "us-west2-a"
}

resource "google_compute_instance" "vm_instance" {
  name = "gke"
  machine_type = "f1-micro"      
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }
}

