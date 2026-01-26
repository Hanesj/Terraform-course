data "aws_availability_zones" "azs" {
  state = "available"
}

locals {
  vpc_cidr              = "10.0.0.0/16"
  private_subnets_cidrs = ["10.0.0.0/24"]
  public_subnets_cidrs  = ["10.0.128.0/24"]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.5.3"

  azs = data.aws_availability_zones.azs.names

  cidr            = local.vpc_cidr
  name            = local.project
  private_subnets = local.private_subnets_cidrs
  public_subnets  = local.public_subnets_cidrs

  tags = local.common_tags
}
