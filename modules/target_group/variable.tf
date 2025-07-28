variable "target_group_arn" {
  description = "ARN of the default target group for the HTTPS listener"
  type        = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "instance_ids" {
  type = list(string)
}

variable "health_check_path" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_name" {
  type = string
}

variable "vpc_id" {
  type = string
}
