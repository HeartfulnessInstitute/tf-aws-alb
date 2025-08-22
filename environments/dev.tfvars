aws_region                 = "ap-south-1"
internal                   = false
security_groups            = ["sg-067f0a23c7bd10cef"]
project_name               = "hfn-project"
environment                = "dev"
enable_deletion_protection = true
app_name = "stagecare"
port = [80, 443]
load_balancer_name = "HFN-ALB"

# Target Group Settings
target_group_protocol        = "HTTP"
target_type                  = "instance"
target_group_port            = 80

# Health Checks
health_check_path            = "/healthy.html"
health_check_protocol        = "HTTP"
health_check_interval        = 30
health_check_timeout         = 5
health_check_healthy_threshold   = 3
health_check_unhealthy_threshold = 2

# Listener settings
listener_port                = 80
listener_protocol            = "HTTP"





