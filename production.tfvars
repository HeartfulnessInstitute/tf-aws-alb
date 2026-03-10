# AWS Region
aws_region = "ap-south-1"

# Load Balancer Settings
alb_name = "tf-hfn-prod-elb"

internal = false
enable_deletion_protection = true

subnet_ids = [
  "subnet-0a12345abcd",
  "subnet-0e4f5g6h"
]

vpc_id = "vpc-00e54a101ae3e3e9d"

tags = {
  Environment = "production"
  Project     = "donation-strapi"
  Owner       = "heartfulness"
}
