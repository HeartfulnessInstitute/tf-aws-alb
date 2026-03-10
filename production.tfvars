# AWS Region
aws_region = "ap-south-1"

# Load Balancer Settings
alb_name = "tf-hfn-prod-elb"

internal = false
enable_deletion_protection = true

subnet_ids = [
  "subnet-07e708b4c41b75214",
  "subnet-0cdbc58b510d8f728"
]

vpc_id = "vpc-00e54a101ae3e3e9d"

tags = {
  Environment = "production"
  Project     = "donation-strapi"
  Owner       = "heartfulness"
}
