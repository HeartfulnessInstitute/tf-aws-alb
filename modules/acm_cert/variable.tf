variable "acm_domain_name" {
  type = string
}

variable "route53_zone_id" {
  description = "The ID of the hosted zone in Route53"
  type        = string
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}
