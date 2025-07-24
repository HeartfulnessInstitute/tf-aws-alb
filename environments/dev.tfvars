aws_region                 = "ap-south-1"
name                       = "dev-care-lb"
internal                   = false
security_groups            = ["sg-067f0a23c7bd10cef"]
subnets                    = ["subnet-09c084ea51ba7939c", "subnet-07fe52885b94b8ec5"]
enable_deletion_protection = false
idle_timeout               = 60

tags = {
  Environment = "dev"
  Owner       = "dev-team"
}

# Target Group Settings
target_group_protocol        = "HTTP"
target_type                  = "instance"
vpc_id                      = "vpc-01a64c15484c80c1d"
target_group_name = "dev-care-app-tg"
target_group_port = 80

# Health Checks
health_check_path            = "/health"
health_check_protocol        = "HTTP"
health_check_interval        = 30
health_check_timeout         = 5
health_check_healthy_threshold   = 3
health_check_unhealthy_threshold = 2

# Listener settings
listener_port               = 80
listener_protocol           = "HTTP"

# Domain and ACM for HTTPS
acm_domain_name = "dev.care.heartfulness.org"
domain_name                 = "dev.care.heartfulness.org"
route53_zone_id             = "Z00231483BIHK"  # Replace with  actual hosted zone ID

# Ports for target groups
default_port                = 80
api_port                    = 8080
app_port                    = 3000

# EC2 instances attached to target groups (fill your instance IDs)
api_instance_ids            = ["i-00af2e73a2a19774e"] 
app_instance_ids            = ["i-09d0dff431490620d"] 

# terraform plan -var-file="environments/dev.tfvars"


