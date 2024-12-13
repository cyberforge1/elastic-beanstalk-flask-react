# terraform/s3.tf

resource "aws_s3_bucket" "production_build_bucket" {
  bucket = var.s3_bucket_name


  tags = {
    Name        = "ProductionBuildBucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.production_build_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.production_build_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "production_build_zip" {
  bucket = aws_s3_bucket.production_build_bucket.id
  key    = "production_build.zip"
  source = "../production_build/production_build.zip"

  content_type = "application/zip"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.production_build_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
