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
    connection {
      type = "ssh"
      user = "${var.user}"
      host = "${self.network_interface.0.network_ip}"
      bastion_host = "${google_compute_address.bastion_ip.address}"
      private_key = "${file("~/.ssh/google_compute_engine")}"
    }
    inline = [
      "sudo touch /etc/apt/sources.list.d/pgdg.list",
      "echo 'deb http://apt.postgresql.org/pub/repos/apt/ 18.04-pgdg main' | sudo tee -a /etc/apt/sources.list.d/pgdg.list",
      "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -",
      "sudo apt-get update -y",
      "sudo apt install postgresql -y",
    ]
  }
}

