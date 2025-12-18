# =====================================================
# Storage Resources
# =====================================================

# Random suffix for GCS bucket to avoid collisions
resource "random_id" "landing_zone_suffix" {
  byte_length = 4
}

# Create landing zone bucket in sandbox-raw project
resource "google_storage_bucket" "landing_zone" {
  name                        = "landing-zone-${random_id.landing_zone_suffix.hex}"
  project                     = google_project.sandbox_raw.project_id
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true
  labels                      = local.sandbox_raw_labels

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 90
    }
    action {
      type          = "SetStorageClass"
      storage_class = "NEARLINE"
    }
  }

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type          = "SetStorageClass"
      storage_class = "COLDLINE"
    }
  }

  lifecycle_rule {
    condition {
      age = 730
    }
    action {
      type = "Delete"
    }
  }
}

# =====================================================
# BigQuery Resources
# =====================================================

# Create BigQuery dataset in sandbox-raw project
resource "google_bigquery_dataset" "sandbox_raw_dataset" {
  dataset_id                 = var.sandbox_raw_dataset_name
  project                    = google_project.sandbox_raw.project_id
  location                   = var.region
  friendly_name              = var.sandbox_raw_dataset_name
  description                = "Raw data landing zone for sandbox environment"
  delete_contents_on_destroy = true
  labels                     = local.sandbox_raw_labels

  depends_on = [google_project_service.sandbox_raw_services]
}
