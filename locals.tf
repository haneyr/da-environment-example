locals {
  # Common labels for all resources
  common_labels = {
    environment         = "analytics"
    managed_by          = "terraform"
    cost_center         = "data-analytics"
    data_classification = "confidential"
    team                = "analytics-platform"
  }

  # Project-specific labels
  sandbox_raw_labels = merge(local.common_labels, {
    project_type = "sandbox"
    data_tier    = "raw"
  })

  sandbox_gold_labels = merge(local.common_labels, {
    project_type = "sandbox"
    data_tier    = "gold"
  })

  admin_labels = merge(local.common_labels, {
    project_type = "administrative"
    purpose      = "capacity-management"
  })

  # API services to enable
  sandbox_raw_services = [
    "bigquery.googleapis.com",
    "dataplex.googleapis.com",
    "datalineage.googleapis.com",
    "storage.googleapis.com",
    "dataflow.googleapis.com",
    "compute.googleapis.com"
  ]

  sandbox_gold_services = [
    "bigquery.googleapis.com",
    "dataplex.googleapis.com",
    "datalineage.googleapis.com",
    "storage.googleapis.com",
    "compute.googleapis.com"
  ]

  admin_services = [
    "bigquery.googleapis.com",
    "compute.googleapis.com"
  ]

  # IAM role mappings for DAEng group at Sandbox folder
  daeng_sandbox_roles = [
    "roles/bigquery.dataEditor",
    "roles/bigquery.jobUser",
    "roles/dataflow.developer",
    "roles/dataplex.editor",
    "roles/storage.admin",
    "roles/serviceusage.serviceUsageAdmin"
  ]

  # IAM role mappings for DAUsers group at sandbox-gold project
  dausers_sandbox_gold_roles = [
    "roles/bigquery.dataViewer",
    "roles/bigquery.jobUser",
    "roles/bigquery.user"
  ]

  # IAM role mappings for DAAdmin group at admin-bq-slots project
  daadmin_admin_project_roles = [
    "roles/bigquery.resourceAdmin",
    "roles/serviceusage.serviceUsageAdmin"
  ]
}
