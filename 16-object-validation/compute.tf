locals {
  allowed_instance_types = ["t2.micro", "t3.micro"]
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

# output "ubuntu_ami" {
#   value = data.aws_ami.ubuntu
# }

resource "aws_instance" "this" {
  ami = data.aws_ami.ubuntu.id
  #   associate_public_ip_address = true
  instance_type = var.instance_type
  subnet_id     = aws_subnet.this[0].id

  #   root_block_device {
  #     delete_on_termination = true
  #     volume_size = 10
  #     volume_type = "gp3"
  #   }
  lifecycle {
    create_before_destroy = true
    #   precondition {
    #     condition = contains(local.allowed_instance_types, var.instance_type)
    #     error_message = "Invalid instance type."
    #   }
    # postcondition ar battre for att om man hardkodar ett varde sa kollar
    # postcondition vad som har blivit skapat
    postcondition {
      condition     = contains(local.allowed_instance_types, self.instance_type)
      error_message = "Instance type is not correct"
    }

  }
  tags = {
    CostCenter = "123"
  }

}

check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter != "")
    error_message = "Your aws instasnce does not have cost center tag."
  }
}