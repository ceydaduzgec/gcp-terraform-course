provider "google" {
  project = "terraform-453318" # The name of the project you created
  region  = "us-central1" # The region where you want to create the resources
  zone    = "us-central1-a" # The zone where you want to create the resources
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  deletion_protection = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.id
    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}
