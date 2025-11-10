# Dev Environment Configuration
# Sandbox Account: 502390415551

# VPC Configuration - Default VPC for sandbox account
vpc_id = "vpc-9bbf8bf3"

# Public Subnets - Default subnets for multiple AZs (required for ALB)
public_subnet_ids = [
  "subnet-a4b9e4cc",  # ap-south-1a
  "subnet-e5fe7ca9"   # ap-south-1b
]

# Target Port
target_port = 80

# ACM Certificate Domain (using a valid domain format for testing)
acm_domain_name = "dev-platform.heartfulness.org"

# Route53 Zone ID (new hosted zone in dev account)
route53_zone_id = "Z08168851W5DQRMVANFP7"

# Target Groups and Host Headers (configure as needed)
target_group_arns = {}
host_headers = {}

# Tags
tags = {
  Environment = "dev"
  Account     = "502390415551"
  Purpose     = "Sandbox Testing"
  ManagedBy   = "Terraform"
  Project     = "Data Platform"
  RunId       = "dev-2025-11-06"
}
