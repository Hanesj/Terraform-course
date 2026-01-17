variable "pm_pass" {
  type      = string
  sensitive = true
}
terraform {
  required_version = ">= 1.14.0"

  # backend = var state lagras, om inte angivet sa lokalt.
  #   backend "" { }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.2-rc04"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }


}
provider "aws" {
  profile    = "localstack"
  region     = "us-east-1"
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
provider "aws" {
  profile    = "localstack"
  region     = "eu-west-1"
  alias      = "eu-west"
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

resource "aws_s3_bucket" "us_east_1" {
  bucket = "random-us-east-1"
}
resource "aws_s3_bucket" "eu-west-1" {
  bucket   = "random-eu-west-1"
  provider = aws.eu-west
}