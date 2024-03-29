resource "google_compute_instance" "bastion" {
  name = "bastion"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"

  tags = ["bastion"]
  
  network_interface {
    network = "${google_compute_network.vpc.name}" 
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
