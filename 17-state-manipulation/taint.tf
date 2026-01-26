resource "aws_s3_bucket" "tainted" {
  bucket = "tainted-bucket-123asd2"
}

# Taintar man en resurs som andra ar beroende av 
# sa kommer den beroende att omskapas ocksa 

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  cidr_block = "10.0.0.0/24"
  vpc_id     = aws_vpc.this.id

}

resource "aws_s3_bucket_public_access_block" "from_tainted" {
  bucket = aws_s3_bucket.tainted.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}