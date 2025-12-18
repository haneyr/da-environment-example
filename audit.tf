# =====================================================
# Audit Logging Configuration
# =====================================================

# Audit logging for sandbox-raw project
resource "google_project_iam_audit_config" "sandbox_raw_audit" {
  project = google_project.sandbox_raw.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }

  audit_log_config {
    log_type = "DATA_READ"
    exempted_members = [
      "group:${var.daadmin_group_email}"
    ]
  }
}

# Audit logging for sandbox-gold project
resource "google_project_iam_audit_config" "sandbox_gold_audit" {
  project = google_project.sandbox_gold.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }

  audit_log_config {
    log_type = "DATA_READ"
    exempted_members = [
      "group:${var.daadmin_group_email}"
    ]
  }
}

# Audit logging for admin-bq-slots project
resource "google_project_iam_audit_config" "admin_bq_slots_audit" {
  project = google_project.admin_bq_slots.project_id
  service = "allServices"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }
}

# BigQuery-specific audit logging with more granular control
resource "google_project_iam_audit_config" "sandbox_raw_bigquery_audit" {
  project = google_project.sandbox_raw.project_id
  service = "bigquery.googleapis.com"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}

# Dataplex audit logging
resource "google_project_iam_audit_config" "sandbox_raw_dataplex_audit" {
  project = google_project.sandbox_raw.project_id
  service = "dataplex.googleapis.com"

  audit_log_config {
    log_type = "ADMIN_READ"
  }

  audit_log_config {
    log_type = "DATA_READ"
  }

  audit_log_config {
    log_type = "DATA_WRITE"
  }
}
