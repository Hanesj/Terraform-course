resource "aws_s3_bucket" "variables" {
  bucket = local.owner

  tags = merge(local.common_tags, var.additional_tags)

}