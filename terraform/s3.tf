# This is the S3 bucket where the VM images are stored temporarily
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = "${var.tags}"
}
