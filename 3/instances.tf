resource "google_compute_instance" "web_server" {
  name         = "${var.app_name}-web-server"
  machine_type = "e2-micro"
  zone         = var.zone

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
    <html>
      <body>
        <h1>Hello from Terraform on GCP!</h1>
        <p>Hostname: $(hostname)</p>
        <p>This server was created using Infrastructure as Code</p>
      </body>
    </html>
    HTML
    systemctl enable apache2
    systemctl start apache2
  EOF
}
