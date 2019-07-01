
provider "google" {
  credentials = "${var.json}"
  project = "${var.project}"
  region = "us-west2"
}

resource "google_container_cluster" "primary" {
  name = "gkecluster"
  remove_default_node_pool = true
  initial_node_count = 1
  location = "us-west2"

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "gkepool" {
  name = "gkepool"
  cluster = "${google_container_cluster.primary.name}"
  node_count = 1
  location = "us-west2"

  node_config {
    preemptible = true
    machine_type = "n1-standard-1"
    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
