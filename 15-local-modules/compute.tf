locals {
  instance_type = "t2.micro"
  project = "15-local-modules"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "this" {
    ami = data.aws_ami.ubuntu.id
    instance_type = local.instance_type

    subnet_id = module.vpc.private_subnets["subnet_1"].subnet_id 
  
}