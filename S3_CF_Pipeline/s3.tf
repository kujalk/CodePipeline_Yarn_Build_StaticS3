resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  acl           = "private"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "public-block" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket_policy" "prod_website" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<POLICY
{    
    "Version": "2012-10-17",    
    "Statement": 
    [ 
        {
            "Sid": "cloud-front-read-access",
            "Effect": "Allow",
            "Principal": {
                "CanonicalUser": "${aws_cloudfront_origin_access_identity.cf.s3_canonical_user_id}"
                },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
        },
        {
            "Sid": "iam-user-full-access",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.user.arn}"
                },
            "Action": "s3:*",
            "Resource": ["arn:aws:s3:::${aws_s3_bucket.bucket.id}","arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"]
        }
    ]
}
POLICY
}