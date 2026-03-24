resource "aws_s3_bucket" "first" {
    bucket = "${var.s3_name_prefix}-first-bucket"

    tags = {
        Name = "first bucket"
        Environment = "dev"
    }
}