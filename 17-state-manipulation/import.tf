#
#   1. import via cli
#   2. import via backend.
#

resource "aws_s3_bucket" "remote_state" {
  bucket = "tf-state"

  tags = {
    ManagedBy = "Terraform"
    lifecycle = "Critical"
  }
  lifecycle {
    # prevent_destroy = true
  }
}

import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = aws_s3_bucket.remote_state.bucket
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = false

}