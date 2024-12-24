# terraform/variables.tf

variable "region" {
  type        = string
  description = "The AWS region to deploy the infrastructure into."
  default     = "ap-southeast-2"
}

variable "project_name" {
  type        = string
  description = "Name of the project for resource naming."
  default     = "my-unique-project"
}

variable "application_name" {
  type        = string
  description = "The name of the Elastic Beanstalk application."
  default     = "my-custom-beanstalk-app"
}

variable "environment_name" {
  type        = string
  description = "The name of the Elastic Beanstalk environment."
  default     = "my-custom-env"
}

variable "s3_bucket_name" {
  type        = string
  description = "Full name of the S3 bucket. Must be globally unique."
  default     = "eb-app-bucket-zlbzsdxm"  # Ensure this is globally unique
}

variable "artifact_file" {
  type        = string
  description = "Path to the ZIP file containing the application bundle."
  default     = "../production_build/elastic-beanstalk-flask-react.zip"  # Corrected relative path
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EB environment."
  default     = "t3.medium"
}

variable "solution_stack_name" {
  type        = string
  description = "Platform stack for the EB environment."
  default     = "64bit Amazon Linux 2023 v4.3.2 running Python 3.9"
}