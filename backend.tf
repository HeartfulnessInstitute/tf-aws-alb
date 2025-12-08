 terraform {
  backend "s3" {
    bucket         = "hfn-alb-state-bucket"
    key            = "staging/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
