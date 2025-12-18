# =====================================================
# Service Accounts
# =====================================================

# Dataflow worker service account for sandbox-raw
resource "google_service_account" "dataflow_worker_raw" {
  account_id   = "dataflow-worker-raw"
  display_name = "Dataflow Worker Service Account (Raw)"
  description  = "Service account for Dataflow jobs in sandbox-raw project"
  project      = google_project.sandbox_raw.project_id
}

# BigQuery data processor service account for sandbox-raw
resource "google_service_account" "bq_processor_raw" {
  account_id   = "bq-data-processor-raw"
  display_name = "BigQuery Data Processor (Raw)"
  description  = "Service account for BigQuery data processing jobs in raw zone"
  project      = google_project.sandbox_raw.project_id
}

# Dataplex service account for sandbox-raw
resource "google_service_account" "dataplex_sa_raw" {
  account_id   = "dataplex-service-raw"
  display_name = "Dataplex Service Account (Raw)"
  description  = "Service account for Dataplex operations in sandbox-raw"
  project      = google_project.sandbox_raw.project_id
}

# Data ingestion service account for sandbox-raw
resource "google_service_account" "data_ingestion_raw" {
  account_id   = "data-ingestion-raw"
  display_name = "Data Ingestion Service Account"
  description  = "Service account for data ingestion pipelines"
  project      = google_project.sandbox_raw.project_id
}

# Grant necessary permissions to dataflow worker
resource "google_project_iam_member" "dataflow_worker_raw_permissions" {
  for_each = toset([
    "roles/dataflow.worker",
    "roles/storage.objectAdmin",
    "roles/bigquery.dataEditor"
  ])

  project = google_project.sandbox_raw.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.dataflow_worker_raw.email}"
}

# Grant permissions to BQ processor
resource "google_project_iam_member" "bq_processor_raw_permissions" {
  for_each = toset([
    "roles/bigquery.jobUser",
    "roles/bigquery.dataEditor"
  ])

  project = google_project.sandbox_raw.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.bq_processor_raw.email}"
}

# Grant permissions to Dataplex service account
resource "google_project_iam_member" "dataplex_sa_raw_permissions" {
  for_each = toset([
    "roles/dataplex.editor",
    "roles/bigquery.dataEditor",
    "roles/storage.objectAdmin"
  ])

  project = google_project.sandbox_raw.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.dataplex_sa_raw.email}"
}

# Grant permissions to data ingestion service account
resource "google_project_iam_member" "data_ingestion_raw_permissions" {
  for_each = toset([
    "roles/storage.objectCreator",
    "roles/bigquery.dataEditor"
  ])

  project = google_project.sandbox_raw.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.data_ingestion_raw.email}"
}

# Service account for sandbox-gold
resource "google_service_account" "bq_processor_gold" {
  account_id   = "bq-data-processor-gold"
  display_name = "BigQuery Data Processor (Gold)"
  description  = "Service account for BigQuery data processing in gold zone"
  project      = google_project.sandbox_gold.project_id
}

# Grant permissions to gold BQ processor
resource "google_project_iam_member" "bq_processor_gold_permissions" {
  for_each = toset([
    "roles/bigquery.jobUser",
    "roles/bigquery.dataViewer"
  ])

  project = google_project.sandbox_gold.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.bq_processor_gold.email}"
}

# Allow sandbox-gold to read from sandbox-raw
resource "google_project_iam_member" "gold_read_raw" {
  project = google_project.sandbox_raw.project_id
  role    = "roles/bigquery.dataViewer"
  member  = "serviceAccount:${google_service_account.bq_processor_gold.email}"
}
