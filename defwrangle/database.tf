resource "google_compute_instance" "postgres" {
  name = "postgres"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"
  
  network_interface {
    network = "default" 
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

