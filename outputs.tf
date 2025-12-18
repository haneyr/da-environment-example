output "analytics_folder_id" {
  description = "The ID of the Analytics folder"
  value       = google_folder.analytics.id
}

output "analytics_folder_name" {
  description = "The name of the Analytics folder"
  value       = google_folder.analytics.name
}

output "sandbox_folder_id" {
  description = "The ID of the Sandbox folder"
  value       = google_folder.sandbox.id
}

output "sandbox_folder_name" {
  description = "The name of the Sandbox folder"
  value       = google_folder.sandbox.name
}

output "production_folder_id" {
  description = "The ID of the Production folder"
  value       = google_folder.production.id
}

output "production_folder_name" {
  description = "The name of the Production folder"
  value       = google_folder.production.name
}

output "administrative_folder_id" {
  description = "The ID of the Administrative folder"
  value       = google_folder.administrative.id
}

output "administrative_folder_name" {
  description = "The name of the Administrative folder"
  value       = google_folder.administrative.name
}

output "sandbox_raw_project_id" {
  description = "The ID of the sandbox-raw project"
  value       = google_project.sandbox_raw.project_id
}

output "sandbox_raw_project_number" {
  description = "The project number of the sandbox-raw project"
  value       = google_project.sandbox_raw.number
}

output "admin_bq_slots_project_id" {
  description = "The ID of the admin-bq-slots project"
  value       = google_project.admin_bq_slots.project_id
}

output "admin_bq_slots_project_number" {
  description = "The project number of the admin-bq-slots project"
  value       = google_project.admin_bq_slots.number
}

output "sandbox_gold_project_id" {
  description = "The ID of the sandbox-gold project"
  value       = google_project.sandbox_gold.project_id
}

output "sandbox_gold_project_number" {
  description = "The project number of the sandbox-gold project"
  value       = google_project.sandbox_gold.number
}

output "landing_zone_bucket_name" {
  description = "The name of the landing zone GCS bucket"
  value       = google_storage_bucket.landing_zone.name
}

output "landing_zone_bucket_url" {
  description = "The URL of the landing zone GCS bucket"
  value       = google_storage_bucket.landing_zone.url
}

output "sandbox_raw_dataset_id" {
  description = "The ID of the BigQuery dataset in sandbox-raw project"
  value       = google_bigquery_dataset.sandbox_raw_dataset.dataset_id
}

output "sandbox_raw_dataset_location" {
  description = "The location of the BigQuery dataset in sandbox-raw project"
  value       = google_bigquery_dataset.sandbox_raw_dataset.location
}
