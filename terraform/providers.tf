terraform {
  required_version = ">=1.7.0, < 2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "resume-website-terraform"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }


}

provider "aws" {
  region = "us-east-1"
}

locals {
  mime_types = {
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    gif  = "image/gif"
    svg  = "image/svg+xml"
    pdf  = "application/pdf"
  }
}
