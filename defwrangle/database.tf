resource "google_compute_instance" "postgres" {
  name = "postgres"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"

  tags = ["postgres"]
  
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
  provisioner "file" {
    source = "./scripts"
    destination = "./"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x ./scripts/postgres.sh",
      "sudo ./scripts/postgres.sh",
      "cd sampleData/psql",
      "chmod +x init.sh",
      "./init.sh",
    ]
  }
  connection {
    type = "ssh"
    user = "${var.user}"
    host = "${self.network_interface.0.network_ip}"
    bastion_host = "${google_compute_address.bastion_ip.address}"
    private_key = "${file("~/.ssh/google_compute_engine")}"
  }
}

