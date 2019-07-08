resource "google_compute_instance" "postgres" {
  name = "postgres"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"

  tags = ["postgres"]

  network_interface {
    network = "${google_compute_network.vpc.name}" 
  }
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  # preemptiable -> lower cost for dev
  scheduling {
    preemptible = true
    automatic_restart = false
  }
}

