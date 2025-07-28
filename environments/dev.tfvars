aws_region                 = "ap-south-1"
availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
load_balancer_name         = "dev-care-lb"
internal                   = false
security_groups            = ["sg-067f0a23c7bd10cef"]
subnets = data.aws_subnets.public.ids
project_name               = "hfn-project"
environment                = "dev"
enable_deletion_protection = true
app_name = "myapp"

# Target Group Settings
target_group_protocol        = "HTTP"
target_type                  = "instance"
vpc_id                       = "vpc-01a64c15484c80c1d"
target_group_name            = "dev-care-app-tg"
target_group_port            = 80

# Health Checks
health_check_path            = "/health"
health_check_protocol        = "HTTP"
health_check_interval        = 30
health_check_timeout         = 5
health_check_healthy_threshold   = 3
health_check_unhealthy_threshold = 2

# Listener settings
listener_port                = 80
listener_protocol            = "HTTP"

# Domain and ACM for HTTPS
acm_domain_name              = "dev.care.heartfulness.org"
domain_name                  = "dev.care.heartfulness.org"
route53_zone_id              = "Z00231483BIHK"  




