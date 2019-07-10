resource "google_compute_instance" "elasticsearch" {
  name = "elasticsearch"
  machine_type = "n1-standard-1"
  zone = "us-west2-a"
  
  tags = ["elasticsearch"]

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
    source = "./scripts/setupES.sh"
    destination = "/tmp/setupES.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setupES.sh",
      "/tmp/setupES.sh",
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
