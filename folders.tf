# =====================================================
# Folder Resources
# =====================================================

# Create Analytics top-level folder
resource "google_folder" "analytics" {
  display_name        = "Analytics"
  parent              = "organizations/${var.organization_id}"
  deletion_protection = false
}

# Create Sandbox folder under Analytics
resource "google_folder" "sandbox" {
  display_name        = "Sandbox"
  parent              = google_folder.analytics.name
  deletion_protection = false
}

# Create Production folder under Analytics
resource "google_folder" "production" {
  display_name        = "Production"
  parent              = google_folder.analytics.name
  deletion_protection = false
}

# Create Administrative folder under Analytics
resource "google_folder" "administrative" {
  display_name        = "Administrative"
  parent              = google_folder.analytics.name
  deletion_protection = false
}
