# terraform/outputs.tf

output "application_name" {
  description = "Elastic Beanstalk Application Name"
  value       = aws_elastic_beanstalk_application.main.name
}

output "environment_name" {
  description = "Elastic Beanstalk Environment Name"
  value       = aws_elastic_beanstalk_environment.main.name
}

output "environment_url" {
  description = "URL endpoint of the EB environment"
  value       = aws_elastic_beanstalk_environment.main.endpoint_url
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket storing the application bundle"
  value       = aws_s3_bucket.eb_bucket.bucket
}
