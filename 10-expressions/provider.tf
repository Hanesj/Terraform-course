terraform {
  required_version = ">= 1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
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

provider "proxmox" {
  pm_api_url      = "https://192.168.1.170:8006/api2/json"
  pm_tls_insecure = true

  #   pm_user = "terraform-prov@pve"


  pm_api_token_id     = "terraform-prov@pve!abc"
  pm_api_token_secret = var.PM_API
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