variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"  
}

variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
  default = "vpc-01a64c15484c80c1d"
}

variable "availability_zones" {
  description = "List of Availability Zones to use"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
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