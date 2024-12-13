# terraform/variables.tf

variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store production builds."
  type        = string
}

variable "iam_user_name" {
  description = "The name of the IAM user to access the S3 bucket."
  type        = string
  default     = "terraform-s3-user"
}
