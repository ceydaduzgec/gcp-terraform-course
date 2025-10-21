terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
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

resource "google_compute_firewall" "web" {
  name    = "allow-web"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# INSTANCE
resource "google_compute_instance" "web_server" {
  count        = 1
  name         = "development-web-server"
  machine_type = "e2-micro"
  zone         = "us-central1-a" # The zone where you want to create the resources

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.name
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    cat <<HTML > /var/www/html/index.html
    <html><body><h1>Hello from development environment!</h1>
    <h2>Server ${count.index}</h2></body></html>
    EOF

}

output "web_server_ips" {
  value = google_compute_instance.web_server[*].network_interface[0].access_config[0].nat_ip
}
