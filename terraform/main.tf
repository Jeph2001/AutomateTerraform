resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucketname
}

resource "aws_s3_bucket_ownership_controls" "mybucketownership" {
  bucket = aws_s3_bucket.mybucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "mybucketaccess" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "mybucketacl" {
  depends_on = [ 
    aws_s3_bucket_ownership_controls.mybucketownership,
    aws_s3_bucket_public_access_block.mybucketaccess,
   ]

   bucket = aws_s3_bucket.mybucket.id
   acl = "public-read"
}

# resource "github_repository" "AutomateTerraform" {
#   name = "AutomateTerraform"
#   description = "This repo is created using Terraform"
#   visibility = "public"
# }

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.mybucket.id
  key = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.mybucket.id
  key = "error.html"
  source = "error.html"
  acl = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "project1" {
  bucket = aws_s3_bucket.mybucket.id
  key = "project1.jpeg"
  source = "project1.jpeg"
  acl  = "public-read"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mybucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "PublicReadGetObject",
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.mybucket.id}/*"
      }
    ]
  })
}


resource "aws_s3_object" "project2" {
  bucket = aws_s3_bucket.mybucket.id
  key = "project2.jpeg"
  source = "project2.jpeg"
  acl = "public-read"
}

resource "aws_s3_object" "project3" {
  bucket = aws_s3_bucket.mybucket.id
  key = "project3.jpeg"
  source = "project3.jpeg"
  acl = "public-read"
}

resource "aws_s3_object" "style" {
  bucket = aws_s3_bucket.mybucket.id
  key = "style.css"
  source = "style.css"
  acl = "public-read"
  content_type = "text/css"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.mybucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }


  depends_on = [ aws_s3_bucket_acl.mybucketacl ]
}