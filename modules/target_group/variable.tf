variable "host" {
  type        = string
  description = "Host condition for listener rule"
  default     = "dev.care.heartfulness.org"
}

variable "path_pattern" {
  type        = string
  description = "Path pattern condition for listener rule"
  default     = "/*"
}

variable "port" {
  type = list(number)
  description = "List of ports for which to create target groups and attachments"
}


variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "acm_certificate_arn" {
  description = "ACM Certificate ARN for HTTPS"
  type        = string
  default = "arn:aws:acm:ap-south-1:502390415551:certificate/f0025adc-7674-4656-93a9-1e111127c9ce"
}

variable "instance_ids" {
  type    = string
  default = "i-00af2e73a2a19774e"
}

variable "protocol" {
  type        = string
  description = "Protocol for target group"
  default     = "HTTP"
}

variable "priority" {
  type        = number
  description = "Priority for listener rule"
  default     = 100
}

variable "health_check_path" {
  type        = string
  description = "Health check path for the target group"
  default     = "/"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {
    Environment = "dev"
    Project     = "care"
  }
}

variable "app_name" {
  type        = string
  description = "Name of the application"
  default     = "stagecare"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the target group"
}

variable "alb_arn" {
  type = string
  description = "ARN of the Application Load Balancer"
}
