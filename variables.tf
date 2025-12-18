variable "organization_id" {
  description = "The numeric ID of the Google Cloud organization"
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.organization_id))
    error_message = "Organization ID must be a numeric string."
  }
}

variable "daadmin_group_email" {
  description = "Email address of the DAAdmin Google Group (e.g., daadmin@example.com)"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.daadmin_group_email))
    error_message = "DAAdmin group email must be a valid email address."
  }
}

variable "daeng_group_email" {
  description = "Email address of the DAEng Google Group (e.g., daeng@example.com)"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.daeng_group_email))
    error_message = "DAEng group email must be a valid email address."
  }
}

variable "dausers_group_email" {
  description = "Email address of the DAUsers Google Group (e.g., dausers@example.com)"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.dausers_group_email))
    error_message = "DAUsers group email must be a valid email address."
  }
}

variable "region" {
  description = "The GCP region or multi-region for resources (e.g., 'us-central1', 'US', 'EU')"
  type        = string
  default     = "US"
}

variable "sandbox_raw_dataset_name" {
  description = "The name of the BigQuery dataset in the sandbox-raw project"
  type        = string
  default     = "raw_data"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_]+$", var.sandbox_raw_dataset_name))
    error_message = "Dataset name must contain only letters, numbers, and underscores."
  }
}

variable "billing_account" {
  description = "The billing account ID to associate with projects (format: XXXXXX-XXXXXX-XXXXXX)"
  type        = string

  validation {
    condition     = can(regex("^[A-F0-9]{6}-[A-F0-9]{6}-[A-F0-9]{6}$", var.billing_account))
    error_message = "Billing account must be in format XXXXXX-XXXXXX-XXXXXX."
  }
}
