terraform {
  required_version = ">= 1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.93.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

variable "PM_API" {
  type      = string
  sensitive = true
}


provider "aws" {
  profile    = "localstack"
  region     = "eu-west-1"
  access_key = "test"
  secret_key = "test"

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://192.168.1.139:4566"
    ec2      = "http://192.168.1.139:4566"
    dynamodb = "http://192.168.1.139:4566"
    lambda   = "http://192.168.1.139:4566"
    iam      = "http://192.168.1.139:4566"
    sts      = "http://192.168.1.139:4566"
  }
}