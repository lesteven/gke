
provider "google" {
  credentials = "${var.json}"
  project = "${var.project}"
  region = "us-west2"
}

