# resource "aws_s3_bucket" "this" {
#     bucket = "random-123120asd0as-d"

# }

removed {
  from = aws_s3_bucket.this_new
  lifecycle {
    destroy = false
  }
}


# resource "aws_s3_bucket" "this_new" {
#     bucket = "random-123120asd0as-d"
# }
