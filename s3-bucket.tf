resource "aws_s3_bucket" "terraform" {
  bucket = "${var.bucket_name}"
}

data "aws_s3_bucket" "ninja-bucket" {
  bucket = aws_s3_bucket.terraform.bucket
}