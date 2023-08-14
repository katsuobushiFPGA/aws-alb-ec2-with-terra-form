terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "ap-northeast-1"
  shared_credentials_files = ["/path/to/dir/.aws/credentials"]
  profile                  = "terraform"
}