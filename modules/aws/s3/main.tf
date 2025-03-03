resource "aws_s3_bucket" "this" {
  bucket = "${var.bucket_name}-${var.environment}"
  tags = {
    environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_s3_bucket_versioning" "versioning_enables" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.status_versioning
  }
}
resource "aws_s3_bucket_ownership_controls" "bucket_dueno_objetos" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "negation_access_public" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

/* resource "aws_iam_policy" "policy-bucket-daco" {
  name        = "bucket_policy-${var.bucket_name}"
  description = "Allow access to bucket-${var.bucket_name}"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : ["s3:Get*", "s3:List*"],
        "Resource" : "${aws_s3_bucket.this.arn}"
      }
    ]
  })
} */