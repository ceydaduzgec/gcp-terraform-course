terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.84.0"
    }
  }
  
  # Configure the backend to use GCS
  backend "gcs" {
    bucket  = "terraform-453318-terraform-state"
    prefix  = "terraform/state"
    
    # Optional: Encrypt state data at rest
    # encryption_key = "..."
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
