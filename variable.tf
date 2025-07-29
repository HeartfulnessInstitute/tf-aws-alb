variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"  # or set via tfvars or CLI
}

variable "availability_zones" {
  description = "List of Availability Zones to use"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  default = "vpc-01a64c15484c80c1d"
}


variable "route53_zone_id" {
  description = "Route 53 hosted zone ID for DNS validation"
  type        = string
  default = "Z00231483BIHK" 
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
  type = list(number)
}


variable "app_name" {
  type = string
  default = "myapp"
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default     = {}
}


