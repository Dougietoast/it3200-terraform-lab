# IT 3200 - M8 Lab 01: Terraform + Infrastructure as Code
# Author: Douglas Casasayas
#
# Creates a private, encrypted S3 bucket with a random suffix
# (bucket names must be globally unique), plus one small text
# object so there is something to verify in the console.

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    # Used to generate a unique suffix for the bucket name
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

# Provider block: tells Terraform which cloud to talk to and where.
# Credentials come from the AWS CLI profile, never from this file.
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  # Every resource this provider creates gets these tags automatically
  default_tags {
    tags = {
      Owner     = var.owner
      Course    = "IT 3200"
      Lab       = "M8-Lab01"
      ManagedBy = "Terraform"
    }
  }
}

# 8 random hex characters appended to the bucket name
resource "random_id" "suffix" {
  byte_length = 4
}

# The bucket itself
resource "aws_s3_bucket" "student" {
  bucket = "${var.bucket_prefix}-${random_id.suffix.hex}"
}

# Block every form of public access (ACLs and bucket policies)
resource "aws_s3_bucket_public_access_block" "student" {
  bucket = aws_s3_bucket.student.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Encrypt objects at rest with S3-managed keys (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "student" {
  bucket = aws_s3_bucket.student.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# A small file managed by Terraform. Because Terraform owns it,
# terraform destroy removes it before deleting the bucket.
resource "aws_s3_object" "hello" {
  bucket       = aws_s3_bucket.student.id
  key          = "hello.txt"
  content      = "Deployed with Terraform by ${var.owner} for IT 3200 M8 Lab 01.\n"
  content_type = "text/plain"
}
