# =====================================================
# API Service Enablement
# =====================================================

# Enable APIs for sandbox-raw project
resource "google_project_service" "sandbox_raw_services" {
  for_each = toset(local.sandbox_raw_services)

  project            = google_project.sandbox_raw.project_id
  service            = each.value
  disable_on_destroy = false
}

# Enable APIs for sandbox-gold project
resource "google_project_service" "sandbox_gold_services" {
  for_each = toset(local.sandbox_gold_services)

  project            = google_project.sandbox_gold.project_id
  service            = each.value
  disable_on_destroy = false
}

# Enable APIs for admin-bq-slots project
resource "google_project_service" "admin_services" {
  for_each = toset(local.admin_services)

  project            = google_project.admin_bq_slots.project_id
  service            = each.value
  disable_on_destroy = false
}
