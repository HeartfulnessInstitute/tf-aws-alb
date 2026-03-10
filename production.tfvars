# AWS Region
aws_region = "ap-south-1"

# Load Balancer Settings
alb_name = "tf-hfn-prod-elb"

internal = false
enable_deletion_protection = true

subnet_ids = [
  "subnet-0786ba8d1ee637880",
  "subnet-0cdac3caa99d7bfab"
]

vpc_id = "vpc-098fdd20f636a1321"

tags = {
  Environment = "production"
  Project     = "donation-strapi"
  Owner       = "heartfulness"
}
