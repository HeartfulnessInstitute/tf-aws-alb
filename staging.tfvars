# AWS Region
aws_region = "ap-south-1"

# Load Balancer Settings
alb_name       = "HFN-ALB"
internal                   = false
enable_deletion_protection = true
port                       = [80, 443]

subnet_ids = ["subnet-0786ba8d1ee637880", "subnet-0cdac3caa99d7bfab"]
vpc_id  = "vpc-098fdd20f636a1321"
