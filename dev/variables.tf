# Dev Variables for ALB Module
# Sandbox Account: 502390415551

variable "vpc_id" {
  description = "VPC ID for dev environment"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB deployment"
  type        = list(string)
}

variable "target_port" {
  description = "Target port for the ALB"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Common tags for dev resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Account     = "502390415551"
    Purpose     = "Sandbox Testing"
    ManagedBy   = "Terraform"
  }
}

variable "acm_domain_name" {
  description = "Domain name for ACM certificate (dev domain)"
  type        = string
}

variable "route53_zone_id" {
  description = "Route53 hosted zone ID for dev"
  type        = string
}

variable "create_target_group" {
  description = "Whether to create a Target Group inside the module"
  type        = bool
  default     = true
}

variable "create_listener_rules" {
  description = "Whether to create HTTPS listener rules inside the module"
  type        = bool
  default     = false
}

variable "target_group_arns" {
  description = "Map of ECS service name to target group ARN"
  type        = map(string)
  default     = {}
}

variable "host_headers" {
  description = "Map of ECS service name to host header"
  type        = map(string)
  default     = {}
}
