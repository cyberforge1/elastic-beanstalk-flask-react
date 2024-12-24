# terraform/s3.tf

provider "aws" {
  region = var.region
}

#############################
# S3 Bucket
#############################
resource "aws_s3_bucket" "eb_bucket" {
  bucket = var.s3_bucket_name

  # Optionally for enhanced security:
  # block_public_acls   = true
  # block_public_policy = true

  tags = {
    Name    = var.s3_bucket_name
    Project = var.project_name
  }
}

#############################
# Upload ZIP to S3 (aws_s3_object)
#############################
resource "aws_s3_object" "eb_app_zip" {
  bucket = aws_s3_bucket.eb_bucket.bucket
  key    = "app-bundles/${var.application_name}.zip"
  source = var.artifact_file
  acl    = "private"

  depends_on = [aws_s3_bucket.eb_bucket]
}

##############################################
# Elastic Beanstalk Application + Version
##############################################
resource "aws_elastic_beanstalk_application" "main" {
  name        = var.application_name
  description = "Flask + React + Nginx Elastic Beanstalk application"

  tags = {
    Project = var.project_name
  }
}

resource "aws_elastic_beanstalk_application_version" "main" {
  name        = "${var.application_name}-v1"
  application = aws_elastic_beanstalk_application.main.name
  bucket      = aws_s3_bucket.eb_bucket.bucket
  key         = aws_s3_object.eb_app_zip.key

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_elastic_beanstalk_application.main, aws_s3_object.eb_app_zip]
}

########################################
# Elastic Beanstalk Environment
########################################
resource "aws_elastic_beanstalk_environment" "main" {
  name                = var.environment_name
  application         = aws_elastic_beanstalk_application.main.name
  solution_stack_name = var.solution_stack_name
  version_label       = aws_elastic_beanstalk_application_version.main.name

  # SingleInstance = cheaper environment (no load balancer)
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_instance_profile.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "FLASK_ENV"
    value     = "production"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  # Ties the EB environment to the EB service role
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.eb_service_role.arn
  }

  tags = {
    Environment = var.environment_name
    Application = var.application_name
    Project     = var.project_name
  }

  depends_on = [
    aws_iam_role.eb_service_role,
    aws_iam_instance_profile.eb_instance_profile
  ]
}
