output "aws_s3_bucket_name" {
  value     = aws_s3_bucket.variables.bucket
  sensitive = true

}

output "sensitive_vale" {
  value       = aws_s3_bucket.variables.bucket
  sensitive   = true
  description = "bucket name"

}

variable "sensitive_var" {
  type      = string
  sensitive = true

}

output "sens" {
  sensitive = true
  value     = var.sensitive_var

}

  