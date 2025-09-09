variable "name_prefix"       { 
    type = string
 }

variable "vpc_id"            { 
    type = string 
}

variable "public_subnet_ids" { 
    type = list(string) 
}

variable "target_port"       {
     type = number
     default = 80 
}

variable "tags"              {
    description = "tags"
     type = map(string)
     default = {}
}

variable "acm_certificate_arn" {
    type = string
}

variable "listener_rules" {
  type = map(string)
  default = {}
}

variable "target_groups" {
  type = map(object({
    port        = number
    health_path = string
  }))
  default = {}
}

variable "target_group_arns" {
  description = "Map of ECS service name to target group ARN"
  type        = map(string)
}

variable "host_headers" {
  description = "Map of ECS service name to host header"
  type        = map(string)
}

variable "acm_domain_name" {
  description = "Domain name for ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Hosted zone ID in Account B"
  type        = string
}

variable "create_target_group" {
  description = "Whether to create a Target Group inside the module"
  type        = bool
  default     = true
}


