module "vpc" {
  source = "./modules/networking"
  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "15-local-modules"
  }
  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-west-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.128.0/24"
      az         = "eu-west-1b"
      public     = true
    }
    subnet_3 = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-west-1c"
    }
    subnet_4 = {
      cidr_block = "10.0.129.0/24"
      az         = "eu-west-1a"
      public = true
    }
  }
}