terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Local Variables
locals {
  common_tags = {
    Environment = var.environment
    Project     = "hfn-project"
    alb_name    = "ALB-HFN-dev"
    app_name    = "myapp"
  }

  idle_timeout_by_env = {
    dev     = 60
    staging = 90
    prod    = 120
  }

  idle_timeout = lookup(local.idle_timeout_by_env, var.environment, 60)
}

# ACM Certificate Module
module "acm" {
  source            = "./modules/acm_cert"
  acm_domain_name   = var.acm_domain_name
  route53_zone_id   = var.route53_zone_id
  tags              = var.tags
}

# VPC Data Source
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["care-dev"]
  }
}

# EC2 Instances Data Source
data "aws_instances" "app_instances" {
  filter {
    name   = "tag:Name"
    values = ["care-server"]
  }
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

# Get Existing ALB by Name
data "aws_lb" "existing_alb" {
  name = local.common_tags.alb_name
}

# Target Group Module
module "target_group" {
  source              = "./modules/target_group"
  app_name            = "dev-care"
  port                = 80
  protocol            = "HTTP"
  vpc_id              = data.aws_vpc.vpc.id
  health_check_path   = "/"
  instance_ids        = data.aws_instances.app_instances.ids
  target_group_arn  = module.target_group.target_group_arn
  tags                = {
    Environment = "dev"
    Project     = "dev-care"
  }
}


# Listener Module
module "listener" {
  source = "./modules/listener"

  target_group_arn  = module.target_group.target_group_arn
  listener_arn      = data.aws_lb_listener.https_listener.arn
  priority          = 100
  host              = "dev.example.com"
  path_pattern      = "/app/*"
  vpc_id            = module.networking.vpc_id
  app_name          = "my-app"  
  instance_ids      = ["i-00af2e73a2a19774e"]  
  health_check_path = "/health"
  tags              = local.common_tags
  port              = [80, 443, 22] 
}

# Networking Module
module "networking" {
  source = "./modules/networking"

  vpc_id = data.aws_vpc.vpc.id
  availability_zone = var.availability_zones[count.index]
}


