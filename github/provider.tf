terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.54.0"
    }
  }

  backend "s3" {
    region = "us-west-2"
    key = "terraform/states/github_oidc/terraform.tfstate"
  }
}

provider "aws" {
  region = "us-west-2"
}
