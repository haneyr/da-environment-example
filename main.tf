terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  # Remote state backend configuration
  # Uncomment and configure once you have a GCS bucket for state storage
  # backend "gcs" {
  #   bucket  = "your-terraform-state-bucket-name"
  #   prefix  = "analytics/terraform.tfstate"
  # }
}

provider "google" {
  # Authentication will use Application Default Credentials (ADC)
  # or GOOGLE_APPLICATION_CREDENTIALS environment variable
}
