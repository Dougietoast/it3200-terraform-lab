output "bucket_name" {
  description = "Name of the bucket Terraform created"
  value       = aws_s3_bucket.student.bucket
}

output "bucket_region" {
  description = "Region the bucket lives in"
  value       = aws_s3_bucket.student.region
}

output "object_key" {
  description = "Key of the sample file in the bucket"
  value       = aws_s3_object.hello.key
}
