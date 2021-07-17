output "user_access_id" {
  value = aws_iam_access_key.key.id
}

output "user_secret_key" {
  value = aws_iam_access_key.key.secret
}

output "cloudfront-domain" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
