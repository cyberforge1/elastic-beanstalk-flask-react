# terraform/outputs.tf

output "s3_bucket_name" {
  description = "Name of the S3 bucket for production builds."
  value       = aws_s3_bucket.production_build_bucket.id
}

output "iam_user_name" {
  description = "Name of the IAM user with access to the S3 bucket."
  value       = aws_iam_user.s3_user.name
}

output "iam_access_key_id" {
  description = "Access Key ID for the IAM user."
  value       = aws_iam_access_key.s3_user_access_key.id
}

output "iam_secret_access_key" {
  description = "Secret Access Key for the IAM user."
  value       = aws_iam_access_key.s3_user_access_key.secret
  sensitive   = true
}
