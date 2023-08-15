resource "aws_s3_bucket_ownership_controls" "ninja-bucket" {
  bucket = data.aws_s3_bucket.ninja-bucket.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "ninja-bucket" {
  bucket = data.aws_s3_bucket.ninja-bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "ninja-bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ninja-bucket,
    aws_s3_bucket_public_access_block.ninja-bucket,
  ]

  bucket = data.aws_s3_bucket.ninja-bucket.bucket
  acl    = "public-read"
}
