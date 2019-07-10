resource "google_compute_instance" "bastion" {
  name = "bastion"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"

  tags = ["bastion"]
  
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
  provisioner "file" {
    source = "./scripts"
    destination = "./"
  }
  provisioner "file" {
    source = "./bastion"
    destination = "./"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x ./scripts/installEs.sh",
      "./scripts/installEs.sh",
      "chmod +x ./scripts/setupPostgres.sh",
      "./scripts/setupPostgres.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    host = "${google_compute_address.bastion_ip.address}"
    private_key = "${file("~/.ssh/google_compute_engine")}"
  }
}

resource "google_compute_address" "bastion_ip" {
  name = "bastion-ip"
}
