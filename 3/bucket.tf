resource "google_storage_bucket" "static_assets" {
  name     = "${var.project_id}-${var.app_name}-assets"
  location = var.region
}

resource "google_storage_bucket_object" "sample_image" {
  name   = "sample.txt"
  bucket = google_storage_bucket.static_assets.name
  content = "This is a sample asset file created by Terraform!"
}
