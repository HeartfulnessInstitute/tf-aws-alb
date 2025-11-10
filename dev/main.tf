# Dev Environment for ALB Module
# Sandbox Account: 502390415551
# This configuration is independent from QA environment

terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS provider for sandbox account
provider "aws" {
  region = "ap-south-1"
}

provider "aws" {
  region = "ap-south-1"
  alias  = "main"
  
  # Default provider configuration for sandbox account 502390415551
}

provider "aws" {
  region = "ap-south-1"
  alias  = "current"
}

# Call the ALB module with dev configuration
module "dev_alb" {
  source = "../"
  
  providers = {
    aws.main = aws.main
  }
  
  name_prefix        = "dev-alb-2025"
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  target_port        = var.target_port
  tags               = merge(var.tags, {
    Environment = "dev"
    Account     = "502390415551"
    Purpose     = "Sandbox Testing"
  })
  
  acm_domain_name           = var.acm_domain_name
  route53_zone_id           = var.route53_zone_id
  create_target_group       = var.create_target_group
  create_listener_rules     = var.create_listener_rules
  target_group_arns         = var.target_group_arns
  host_headers              = var.host_headers
}
