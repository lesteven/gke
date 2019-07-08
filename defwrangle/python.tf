resource "google_compute_instance" "bastion" {
  name = "bastion"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"
  
  network_interface {
    network = "default" 
    access_config {
      nat_ip = "${google_compute_address.bastion_ip.address}"
    }
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

resource "google_compute_address" "bastion_ip" {
  name = "bastion-ip"
}
