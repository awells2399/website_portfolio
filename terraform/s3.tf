resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "static_website" {
  bucket = "${var.bucket_name}-${random_id.bucket_suffix.hex}"
}



resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "static_website_public_read" {
  bucket = aws_s3_bucket.static_website.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.static_website]
}



resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "../static-website-src/index.html"
  content_type = "text/html"
  source_hash  = filemd5("../static-website-src/index.html")
}


resource "aws_s3_object" "css" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "styles.css"
  source       = "../static-website-src/styles.css"
  content_type = "text/css"
  source_hash  = filemd5("../static-website-src/styles.css")
}



resource "aws_s3_object" "source_files" {
  for_each    = { for file in fileset("../static-website-src", "**/*") : file => file if file != "index.html" || file != "styles.css" }
  bucket      = aws_s3_bucket.static_website.id
  key         = each.value
  source      = "../static-website-src/${each.value}"
  source_hash = filemd5("../static-website-src/${each.value}")
}


resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

