variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"  # or set via tfvars or CLI
}

variable "availability_zones" {
  description = "List of availability zones to be used"
  type        = list(string)
}

variable "load_balancer_name" {
  description = "Name of the ALB"
  type        = string
  }


variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}


variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "tags" {
  type = map(string)
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID for DNS validation"
  type        = string
}

variable "acm_domain_name" {
  description = "The domain name to use for ACM certificate"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "port" {
  type = number
}

variable "app_name" {
  type = string
}



