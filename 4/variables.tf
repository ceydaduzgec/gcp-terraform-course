variable "project_id" {
  description = "The GCP Project ID"
  type        = string
  default     = "terraform-453318"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-c"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "terraform-web-app"
}
