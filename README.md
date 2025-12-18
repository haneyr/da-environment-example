# Google Cloud Analytics Platform - Terraform Configuration

This Terraform configuration creates a Google Cloud analytics platform with proper folder hierarchy, projects, IAM permissions, and monitoring.

## Architecture

```
Organization
└── Analytics
    ├── Sandbox
    │   ├── sandbox-raw-{random}
    │   └── sandbox-gold-{random}
    ├── Production
    └── Administrative
        └── admin-bq-slots-{random}
```

## File Structure

- **main.tf** - Terraform and provider configuration
- **locals.tf** - Local variables, labels, and DRY configurations
- **variables.tf** - Input variable definitions
- **outputs.tf** - Output value definitions
- **terraform.tfvars** - Variable values (contains sensitive data)
- **folders.tf** - GCP folder resources
- **projects.tf** - GCP project resources
- **services.tf** - API enablement using for_each loops
- **iam.tf** - IAM role bindings
- **storage.tf** - GCS buckets and BigQuery datasets
- **budgets.tf** - Budget alerts and monitoring
- **audit.tf** - Audit logging configuration
- **service-accounts.tf** - Service accounts for workloads

## Prerequisites

1. Google Cloud Organization
2. Billing account
3. Three Google Groups:
   - analytics-admin@yourdomain.com
   - analytics-eng@yourdomain.com
   - analytics-users@yourdomain.com
4. Terraform >= 1.0
5. gcloud CLI authenticated

## Setup Instructions

### 1. Configure Variables

Edit `terraform.tfvars`:
```hcl
organization_id = "your-org-id"
billing_account = "XXXXXX-XXXXXX-XXXXXX"
daadmin_group_email = "analytics-admin@yourdomain.com"
daeng_group_email = "analytics-eng@yourdomain.com"
dausers_group_email = "analytics-users@yourdomain.com"
region = "us-east1"
sandbox_raw_dataset_name = "raw_data"
```

### 2. (Optional) Configure Remote State

Create a GCS bucket for Terraform state:
```bash
gsutil mb -p your-project -l us-east1 gs://your-terraform-state-bucket
gsutil versioning set on gs://your-terraform-state-bucket
```

Uncomment the backend block in `main.tf` and update the bucket name.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review Plan

```bash
terraform plan
```

### 5. Apply Configuration

```bash
terraform apply
```

## Key Features

### Labels
All resources are tagged with common labels:
- `environment`: analytics
- `managed_by`: terraform
- `cost_center`: data-analytics
- `data_classification`: confidential
- `team`: analytics-platform

### Budget Alerts
Three budget configurations:
- **Analytics Platform Budget**: $10,000/month across all projects
- **Sandbox Budget**: $5,000/month for sandbox projects
- **Admin Budget**: $3,000/month for capacity management

Alerts at 50%, 75%, 90%, 100%, and 110% thresholds.

### Audit Logging
Comprehensive audit logging enabled for:
- All admin operations (ADMIN_READ)
- Data writes (DATA_WRITE)
- Data reads (DATA_READ with exemptions for admin group)

Specific logging for BigQuery and Dataplex services.

### Service Accounts
Dedicated service accounts for:
- Dataflow workers
- BigQuery data processors
- Dataplex operations
- Data ingestion pipelines

### IAM Permissions

**DAAdmin Group:**
- Owner at Analytics folder level
- Dataplex admin at Sandbox folder
- BigQuery resource admin in admin-bq-slots project

**DAEng Group (Sandbox folder):**
- BigQuery data editor and job user
- Dataflow developer
- Dataplex editor
- Storage admin
- Service usage admin

**DAUsers Group (sandbox-gold project):**
- BigQuery data viewer
- BigQuery job user
- BigQuery user

### API Services
Auto-enabled APIs using for_each loops:
- BigQuery
- Dataplex
- Data Lineage
- Cloud Storage
- Dataflow
- Compute Engine

### GCS Lifecycle Rules
Landing zone bucket includes:
- Move to NEARLINE after 90 days
- Move to COLDLINE after 365 days
- Delete after 730 days
- Versioning enabled

## Cost Optimization

1. **Budget alerts** prevent cost overruns
2. **Lifecycle rules** automatically tier data to cheaper storage
3. **Labels** enable cost attribution and analysis
4. **Capacity reservations** in dedicated admin project for predictable BigQuery costs

## Security Best Practices

1. **Audit logging** for compliance and security monitoring
2. **Uniform bucket-level access** on GCS buckets
3. **Service accounts** with least-privilege access
4. **Separate admin project** for capacity management
5. **No default networks** (auto_create_network = false)

## Maintenance

### Adding New Projects
Add to `projects.tf` and update relevant sections in other files.

### Modifying IAM Roles
Update the role lists in `locals.tf` for automatic propagation.

### Updating Budgets
Edit budget amounts in `budgets.tf`.

## Outputs

After applying, view outputs:
```bash
terraform output
```

Key outputs include:
- Folder IDs
- Project IDs and numbers
- Bucket names and URLs
- Dataset information

## Troubleshooting

### API Not Enabled
Wait 30-60 seconds after `terraform apply` for API enablement to propagate.

### Permission Denied
Ensure you have Organization Admin role and are authenticated:
```bash
gcloud auth application-default login
```

### Budget Creation Failed
Ensure you have `billing.admin` role on the billing account.

## Best Practices

1. Always run `terraform plan` before `terraform apply`
2. Use remote state backend for team collaboration
3. Review audit logs regularly
4. Monitor budget alerts
5. Keep Terraform version consistent across team

## License

Internal use only.
