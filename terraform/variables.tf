# terraform/variables.tf

variable "region" {
  type        = string
  description = "The AWS region to deploy the infrastructure into."
  default     = "ap-southeast-2"
}

variable "application_name" {
  type        = string
  description = "The name of the Elastic Beanstalk application."
  default     = "elastic-beanstalk-flask-react"
}

variable "environment_name" {
  type        = string
  description = "The name of the Elastic Beanstalk environment."
  default     = "flask-react-env"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for storing EB application versions."
  default     = "my-flask-react-eb-bucket-example"
}

variable "artifact_file" {
  type        = string
  description = "Path to the ZIP file containing the application bundle."
  default     = "production_build/elastic-beanstalk-flask-react.zip"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EB environment."
  default     = "t2.micro"
}

variable "solution_stack_name" {
  type        = string
  description = "Platform stack for the EB environment."
  default     = "Python 3.9 running on 64bit Amazon Linux 2023"
}
