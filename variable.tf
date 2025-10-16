variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "alb_name" {
  type        = string
  description = "Name for the ALB"
}

variable "internal" {
  type        = bool
  description = "Whether the ALB is internal"
  default     = false
}

variable "ip_address_type" {
  type        = string
  description = "IP address type (ipv4 or dualstack)"
  default     = "ipv4"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for the ALB (usually public subnets)"
}

variable "vpc_id" {
  type        = string
  description = "VPC id where ALB and SG will be created"
}

variable "target_group_name" {
  type        = string
  description = "Target group name"
}

variable "target_port" {
  type        = number
  description = "Port of targets"
  default     = 80
}

variable "target_protocol" {
  type        = string
  description = "Protocol for target group"
  default     = "HTTP"
}

variable "target_type" {
  type        = string
  description = "Target type (instance, ip, lambda)"
  default     = "instance"
}

variable "target_instance_ids" {
  type        = list(string)
  description = "List of instance IDs or target ids to attach to target group (optional)"
  default     = []
}

variable "health_check_path" {
  type        = string
  default     = "/"
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

variable "health_check_matcher" {
  type    = string
  default = "200-399"
}

variable "enable_deletion_protection" {
  type    = bool
  default = false
}

variable "enable_http_redirect" {
  type    = bool
  default = true
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of ACM certificate for HTTPS listener (required if HTTPS is used)"
  default     = ""
}

variable "listener_rule_priority" {
  type    = number
  default = 100
}

variable "host_headers" {
  type    = list(string)
  default = []
}

variable "path_patterns" {
  type    = list(string)
  default = []
}

variable "listener_rules" {
  type    = list(any)
  default = []
}

variable "ingress_rules" {
  type = list(object({
    description       = optional(string)
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_blocks       = optional(list(string))
    ipv6_cidr_blocks  = optional(list(string))
    security_groups   = optional(list(string))
  }))
  description = "Ingress rules for ALB SG"
  default     = [
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "create_target_sg" {
  type    = bool
  default = false
}

variable "additional_target_ingress_rules" {
  type = list(object({
    description     = optional(string)
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = optional(list(string))
    security_groups = optional(list(string))
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
