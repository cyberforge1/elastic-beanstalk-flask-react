# terraform/iam.tf

########################################
# IAM Role for Elastic Beanstalk Service
########################################

# Data for the EB service trust relationship
data "aws_iam_policy_document" "eb_service_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }
  }
}

# The EB service role
resource "aws_iam_role" "eb_service_role" {
  name               = "eb-service-role"
  assume_role_policy = data.aws_iam_policy_document.eb_service_trust.json
}

# Attach an updated managed policy for EB
resource "aws_iam_role_policy_attachment" "eb_service_role_managed_policy" {
  role       = aws_iam_role.eb_service_role.name
  # Use a valid ARN in your account:
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkService"
  # or your custom ARN, e.g. "arn:aws:iam::123456789012:policy/MyCustomEbServiceRolePolicy"
}

########################################
# IAM Role for EC2 Instances in EB
########################################

# Data for the EC2 trust relationship
data "aws_iam_policy_document" "eb_ec2_trust" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# The EC2 instance role
resource "aws_iam_role" "eb_ec2_instance_role" {
  name               = "eb-ec2-instance-role"
  assume_role_policy = data.aws_iam_policy_document.eb_ec2_trust.json
}

# Attach AWS managed policy for the EC2 role
resource "aws_iam_role_policy_attachment" "eb_ec2_instance_role_managed_policy" {
  role       = aws_iam_role.eb_ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

# Instance profile for EB to associate with the EC2 instance role
resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = "eb-ec2-instance-profile"
  role = aws_iam_role.eb_ec2_instance_role.name
}
