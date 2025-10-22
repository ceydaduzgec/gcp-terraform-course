terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.84.0"
    }
  }
}

provider "google" {
  project = "terraform-453318" # The name of the project you created
  region  = "us-central1" # The region where you want to create the resources
  zone    = "us-central1-a" # The zone where you want to create the resources
}

# NETWORK
resource "google_compute_network" "vpc" {
  name                    = "development-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "development-subnet"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1" # The region where you want to create the resources
  network       = google_compute_network.vpc.id
}

# INSTANCE
resource "google_compute_instance" "web_server" {
  name         = "development-web-server"
  machine_type = "e2-micro"
  zone         = "us-central1-a" # The zone where you want to create the resources

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  labels = {
    env = "test"
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
      // Ephemeral IP
    }
  }

}

output "web_server_ips" {
  value = google_compute_instance.web_server.network_interface.0.access_config.0.nat_ip
}
