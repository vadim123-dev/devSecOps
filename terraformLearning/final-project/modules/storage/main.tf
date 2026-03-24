resource "aws_s3_bucket" "first" {
    bucket          = "${var.project_name}-s3-bucket"

    tags = {
        Name        = "${var.project_name}-s3-bucket"
        Environment = var.environment
    }
}


resource "aws_s3_object" "image" {
    bucket          = aws_s3_bucket.first.id
    key             = "uploads/red-head-girl.png"
    source          = "${path.module}/assets/red-head-girl.png"
    content_type    = "image/png"

    # terraform re-uploads if the file content changes
    etag            = filemd5("${path.module}/assets/red-head-girl.png")
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket                  = aws_s3_bucket.first.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.first.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.first.arn}/*"
    }]
  })
  depends_on = [aws_s3_bucket_public_access_block.public]
}