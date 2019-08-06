provider "google" {
  credentials = "${var.json}"
  project = "${var.project}"
  region = "us-west2"
}

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
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install postgresql -y"
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    host = "${self.network_interface.0.network_ip}"
    private_key = "${file("~/.ssh/google_compute_engine")}"
  }
}

