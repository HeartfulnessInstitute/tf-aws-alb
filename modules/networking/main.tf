data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Project"
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

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "public_subnet_ids" {
  value = data.aws_subnets.public.ids
}




