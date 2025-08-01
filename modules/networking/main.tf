data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Project"
    values = ["hfn-project"]
  }
  filter {
    name   = "tag:Name"
    values = ["care-dev"]
  }
  filter {
    name   = "tag:Environment"
    values = ["dev"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Type"
    values = ["Public"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  required_azs = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]

  selected_azs = [
    for az in data.aws_availability_zones.available.names :
    az if contains(local.required_azs, az)
  ]
}

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}

output "selected_availability_zones" {
  value = local.selected_azs
}




