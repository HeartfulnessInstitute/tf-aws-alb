variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "load_balancer_name" {
  type = string
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal"
  type        = bool
}

variable "security_groups" {
  description = "List of security group IDs for the ALB"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "enable_deletion_protection" {
  type        = bool
}

variable "idle_timeout" {
  type        = number
  default     = 60
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "target_group_protocol" {
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  type        = string
  default     = "instance"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_interval" {
  type    = number
  default = 30
}

variable "health_check_timeout" {
  type    = number
  default = 5
}

variable "health_check_healthy_threshold" {
  type    = number
  default = 3
}

variable "health_check_unhealthy_threshold" {
  type    = number
  default = 3
}

variable "acm_domain_name" {
  description = "The domain name to use for ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID for DNS validation"
  type        = string
}


