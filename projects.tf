# =====================================================
# Project Resources
# =====================================================

# Random suffix for project ID to avoid collisions
resource "random_id" "sandbox_raw_suffix" {
  byte_length = 2
}

# Random suffix for admin project ID to avoid collisions
resource "random_id" "admin_bq_slots_suffix" {
  byte_length = 2
}

# Create sandbox-raw project under Sandbox folder
resource "google_project" "sandbox_raw" {
  name                = "sandbox-raw"
  project_id          = "sandbox-raw-${random_id.sandbox_raw_suffix.hex}"
  folder_id           = google_folder.sandbox.name
  billing_account     = var.billing_account
  auto_create_network = false
  deletion_policy     = "DELETE"
  labels              = local.sandbox_raw_labels
}

# Create sandbox-gold project under Sandbox folder (using same random suffix)
resource "google_project" "sandbox_gold" {
  name                = "sandbox-gold"
  project_id          = "sandbox-gold-${random_id.sandbox_raw_suffix.hex}"
  folder_id           = google_folder.sandbox.name
  billing_account     = var.billing_account
  auto_create_network = false
  deletion_policy     = "DELETE"
  labels              = local.sandbox_gold_labels
}

# Create admin-bq-slots project under Administrative folder
resource "google_project" "admin_bq_slots" {
  name                = "admin-bq-slots"
  project_id          = "admin-bq-slots-${random_id.admin_bq_slots_suffix.hex}"
  folder_id           = google_folder.administrative.name
  billing_account     = var.billing_account
  auto_create_network = false
  deletion_policy     = "DELETE"
  labels              = local.admin_labels
}
