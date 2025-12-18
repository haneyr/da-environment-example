# =====================================================
# IAM Bindings
# =====================================================

# DAAdmin group - Admin privileges at Analytics folder level
resource "google_folder_iam_member" "analytics_admin_owner" {
  folder = google_folder.analytics.name
  role   = "roles/owner"
  member = "group:${var.daadmin_group_email}"
}

# DAAdmin group - Dataplex admin privileges at Sandbox folder level
resource "google_folder_iam_member" "sandbox_admin_dataplex_admin" {
  folder = google_folder.sandbox.name
  role   = "roles/dataplex.admin"
  member = "group:${var.daadmin_group_email}"
}

# DAEng group - Engineering privileges at Sandbox folder level (using for_each)
resource "google_folder_iam_member" "sandbox_eng_roles" {
  for_each = toset(local.daeng_sandbox_roles)

  folder = google_folder.sandbox.name
  role   = each.value
  member = "group:${var.daeng_group_email}"
}

# DAUsers group - Read-only access to sandbox-gold project (using for_each)
resource "google_project_iam_member" "sandbox_gold_users_roles" {
  for_each = toset(local.dausers_sandbox_gold_roles)

  project = google_project.sandbox_gold.project_id
  role    = each.value
  member  = "group:${var.dausers_group_email}"
}

# DAAdmin group - BigQuery reservation and capacity management in admin project (using for_each)
resource "google_project_iam_member" "admin_bq_slots_admin_roles" {
  for_each = toset(local.daadmin_admin_project_roles)

  project = google_project.admin_bq_slots.project_id
  role    = each.value
  member  = "group:${var.daadmin_group_email}"
}
