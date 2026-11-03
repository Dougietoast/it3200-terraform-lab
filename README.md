# IT 3200 - M8 Lab 01: Terraform S3 Bucket

Creates a private, encrypted AWS S3 bucket with Terraform, verifies it, then destroys it.

## What it builds
- S3 bucket named `dougietoast-it3200-iac-<random>`
- Public access fully blocked
- Server-side encryption (SSE-S3)
- Tags applied to everything: Owner, Course, Lab, ManagedBy
- A small `hello.txt` object managed by Terraform

## Run it
```bash
aws sts get-caller-identity   # confirm credentials
cd terraform-lab
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
terraform destroy
```

## Repo layout
- `terraform-lab/` - Terraform configuration
- `reflection/` - lab reflection answers
- `screenshots/` - evidence after create and after destroy

## Demo video
[Terraform deploy / destroy / redeploy demo](https://uvu365-my.sharepoint.com/:v:/g/personal/11029967_uvu_edu/IQCOKUd5JbbdR7xQPD8G6cwXAcSKEZuooL_ySMIhOtxjq80)

No credentials or state files are committed (see `.gitignore`).
