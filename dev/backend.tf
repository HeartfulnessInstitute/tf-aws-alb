# Backend configuration for dev environment
terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}
