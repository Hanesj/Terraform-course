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

resource "aws_vpc" "demo_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "Terraform VPC" 
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.0.0/24" 
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "10.0.1.0/24" 
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.demo_vpc.id
}
resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.demo_vpc.id
  
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
}
resource "aws_route_table_association" "public_subnet" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rtb.id  
}