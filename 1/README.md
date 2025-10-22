provider "google" {
  project = "terraform-453318" # The name of the project you created
  region  = "us-central1" # The region where you want to create the resources
  zone    = "us-central1-a" # The zone where you want to create the resources
}

resource "google_compute_instance" "my_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

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
  labels = { # billing, and monitoring purposes
    env = "test"
  }

  tags = ["web-server", "allow-http", "allow-ssh"] # network traffic control and firewall rules
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}