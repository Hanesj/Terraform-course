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

  backend "s3" {
    region = "us-east-1"
    bucket = "tf-state"
    key    = "04-backends/state.tfstate"


    endpoints  = { s3 = "http://192.168.1.139:4566" }
    access_key = "test"
    secret_key = "test"

    use_lockfile = true

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
    force_path_style            = true
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
provider "proxmox" {
  pm_api_url = "https://192.168.1.170:8006/api2/json"

  pm_user     = "terraform-prov@pve"
  pm_password = var.pm_pass

  pm_tls_insecure = true

}

