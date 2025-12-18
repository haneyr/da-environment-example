# =====================================================
# Budget Alerts
# =====================================================

# Budget alert for all analytics projects
resource "google_billing_budget" "analytics_budget" {
  billing_account = var.billing_account
  display_name    = "Analytics Platform Budget"

  budget_filter {
    projects = [
      "projects/${google_project.sandbox_raw.number}",
      "projects/${google_project.sandbox_gold.number}",
      "projects/${google_project.admin_bq_slots.number}"
    ]
    labels = {
      environment = "analytics"
    }
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = "10000" # $10,000 per month
    }
  }

  threshold_rules {
    threshold_percent = 0.5
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 0.75
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 0.9
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.1
    spend_basis       = "CURRENT_SPEND"
  }
}

# Individual budget for sandbox projects
resource "google_billing_budget" "sandbox_budget" {
  billing_account = var.billing_account
  display_name    = "Sandbox Projects Budget"

  budget_filter {
    projects = [
      "projects/${google_project.sandbox_raw.number}",
      "projects/${google_project.sandbox_gold.number}"
    ]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = "5000" # $5,000 per month for sandbox
    }
  }

  threshold_rules {
    threshold_percent = 0.8
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "CURRENT_SPEND"
  }
}

# Budget for admin/capacity management
resource "google_billing_budget" "admin_budget" {
  billing_account = var.billing_account
  display_name    = "Admin BQ Slots Budget"

  budget_filter {
    projects = ["projects/${google_project.admin_bq_slots.number}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = "3000" # $3,000 per month for reservations
    }
  }

  threshold_rules {
    threshold_percent = 0.9
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "CURRENT_SPEND"
  }
}
