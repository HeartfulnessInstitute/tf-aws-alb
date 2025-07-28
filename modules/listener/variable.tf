variable "app_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "listener_arn" {
  type = string
}

variable "host" {
  type = string
}

variable "path_pattern" {
  type = string
}

variable "port" {
  type        = list(number)
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

variable "priority" {
  type = number
}

variable "tags" {
  type = map(string)
}


variable "target_group_arn" {
  description = "ARN of the default target group for the HTTPS listener"
  type        = string
}
