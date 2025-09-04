variable "aws_region" {}

variable "vpc_id" {}

variable "subnets" {
  description = "Subnets for ALB"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups for ALB"
  type        = list(string)
}

variable "acm_certificate_arn" {}

variable "acm_domain_name" {
  description = "Primary domain name for ACM validation"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the ALB"
  type        = string
}

variable "internal" {
  description = "Whether ALB is internal"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
  default     = false
}

variable "ssl_policy" {
  default = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "applications" {
  description = "Map of applications with domain, TG, and rules"
  type = map(object({
    domain             = string
    target_group_name  = string
    priority           = number
    path_patterns      = optional(list(string))
    health_check_path  = optional(string)
    target_ids         = optional(list(string))
  }))
}

