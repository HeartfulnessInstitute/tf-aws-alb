variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone to use"
  type        = string
}

variable "subnet_name" {
  description = "Name tag of the subnet to use"
  type        = string
  default     = "public-subnet"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "hfn-project"
}


variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}