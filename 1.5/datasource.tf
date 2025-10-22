provider "google" {
  project = "terraform-453318"
  region  = "us-central1"
  zone    = "us-central1-a"
}

data "google_compute_image" "latest" {
  family  = "debian-11"
  project = "debian-cloud"
}

data "google_compute_network" "existing" {
  name = "default"
}

data "google_project" "current" {}

data "google_compute_zones" "available" {
  region = "us-central1"
}

output "latest_image_info" {
  value = {
    image_id          = data.google_compute_image.latest.id
    image_name        = data.google_compute_image.latest.name
    image_family      = data.google_compute_image.latest.family
    image_description = data.google_compute_image.latest.description
    image_project     = data.google_compute_image.latest.project
    self_link         = data.google_compute_image.latest.self_link
    creation_date     = data.google_compute_image.latest.creation_timestamp
  }
  description = "Information about the latest Debian 11 image"
}

output "latest_image_name" {
  value       = data.google_compute_image.latest.name
  description = "Name of the latest Debian 11 image (use this in your boot_disk)"
}

output "network_id" {
  value       = data.google_compute_network.existing.id
  description = "Network ID to use in your VM network_interface"
}

output "project_info" {
  value = {
    project_id      = data.google_project.current.project_id
    project_name    = data.google_project.current.name
    project_number  = data.google_project.current.number
    billing_account = data.google_project.current.billing_account
    labels          = data.google_project.current.labels
  }
  description = "Current GCP project information"
}

output "project_id" {
  value       = data.google_project.current.project_id
  description = "Your GCP Project ID"
}

output "project_number" {
  value       = data.google_project.current.number
  description = "Your GCP Project Number"
}

output "zones_info" {
  value = {
    all_zones    = data.google_compute_zones.available.names
    zone_count   = length(data.google_compute_zones.available.names)
    first_zone   = data.google_compute_zones.available.names[0]
    last_zone    = data.google_compute_zones.available.names[length(data.google_compute_zones.available.names) - 1]
  }
  description = "Available zones in us-central1 region"
}

output "available_zones_list" {
  value       = data.google_compute_zones.available.names
  description = "List of all available zones in us-central1"
}
