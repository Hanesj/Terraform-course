#
# 1. terraform state mv ARGS
#
#
#

locals {
  ec2_names = ["instance1", "instance2"]
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

moved {
  from = aws_instance.new_list[0]
  to   = aws_instance.new_list["instance1"]
}
moved {
  from = aws_instance.new_list[1]
  to   = aws_instance.new_list["instance2"]
}

resource "aws_instance" "new_final" {
  for_each      = toset(local.ec2_names)
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
}

moved {
  from = aws_instance.new_list["instance1"]
  to   = aws_instance.new_final
}
moved {
  from = aws_instance.new_list["instance2"]
  to   = module.compute.aws_instance.this
}
module "compute" {
  source = "./modules/compute"

  ami_id = data.aws_ami.ubuntu.id
}