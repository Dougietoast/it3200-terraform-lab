variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-2"
}

variable "aws_profile" {
  description = "AWS CLI profile that holds the credentials"
  type        = string
  default     = "default"
}

variable "bucket_prefix" {
  description = "Start of the bucket name; a random suffix is added"
  type        = string
  default     = "dougietoast-it3200-iac"

  # S3 names: lowercase letters, numbers, hyphens; leave room for the suffix
  validation {
    condition     = can(regex("^[a-z0-9-]{3,50}$", var.bucket_prefix))
    error_message = "Use 3-50 lowercase letters, numbers, or hyphens."
  }
}

variable "owner" {
  description = "Name used in tags and in the sample object"
  type        = string
  default     = "Douglas"
}
