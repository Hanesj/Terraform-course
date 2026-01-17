variable "pm_pass" {
    type = string
    sensitive = true
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    proxmox = {
        source = "Telmate/proxmox"
        version = "3.0.2-rc04"
    }
  }
}

provider "aws" {
    profile = "localstack"
    region = "us-east-1"
    access_key = "test"
    secret_key = "test"

    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_requesting_account_id = true

    endpoints {
      s3 = "http://192.168.1.139:4566"
      ec2 = "http://192.168.1.139:4566"
      dynamodb = "http://192.168.1.139:4566"
      lambda = "http://192.168.1.139:4566"
      iam = "http://192.168.1.139:4566"
      sts = "http://192.168.1.139:4566"
    }
  
}

provider "proxmox" {
    pm_api_url = "https://192.168.1.170:8006/api2/json"

    pm_user = "terraform-prov@pve"
    pm_password = var.pm_pass

    pm_tls_insecure = true
  
}

# Managed by us
resource "aws_s3_bucket" "my_bucket" {
    bucket = var.bucket_name
}

# data is when we want data from external source, not managed by us
data "aws_s3_bucket" "my_external_bucket" {
    bucket = "not-managed-by-us"
}

variable "bucket_name" {
    type = string
    description = "Variable for bucket name"
    default = "default bucket name"
}

output "bucket_id" {
    value = aws_s3_bucket.my_bucket.id
}

locals {
    local_example = "This is a local variable"
}

module "my_module" {
  source = "./module-example"
}