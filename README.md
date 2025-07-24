# AWS ALB with HTTPS (ACM) and EC2 Target Group

This Terraform module creates:
- An Application Load Balancer (ALB)
- An ACM certificate with DNS validation
- Target group with EC2 instances
- HTTPS listener with SSL cert
- HTTP listener that redirects to HTTPS

## Requirements

- AWS Route 53 DNS zone for ACM validation
- Domain managed in Route 53
- EC2 instance(s) in the same VPC

## Usage

```hcl
module "alb" {
  source = "./alb-with-acm"

  name                    = "my-alb"
  internal                = false
  security_groups         = [aws_security_group.alb.id]
  subnets                 = [aws_subnet.public1.id, aws_subnet.public2.id]
  enable_deletion_protection = false

  target_group_name       = "my-target-group"
  target_group_port       = 80
  vpc_id                  = aws_vpc.main.id
  ec2_instance_ids        = [aws_instance.web1.id, aws_instance.web2.id]

  acm_domain_name         = "yourdomain.com"
  route53_zone_id         = "Z123456ABCDEFG"

  tags = {
    Environment = "prod"
    Terraform   = "true"
  }
}


<-- Resources Created -->
ACM Certificate: Automatically requested and validated using DNS records in Route53

Route53 Records: For ACM certificate DNS validation

Application Load Balancer: Internal or internet-facing based on configuration

Target Groups: Default, API, and APP with health checks

Listener (HTTP 80): Redirects all traffic to HTTPS (443)

Listener (HTTPS 443): Uses ACM certificate and routes traffic based on host and path conditions

Listener Rules: Host header and path-based routing rules

Target Group Attachments: Attaches EC2 instances to their respective target groups