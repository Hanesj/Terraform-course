data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/*" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
}

output "ubuntu_ami" {
  value = data.aws_ami.ubuntu
}

resource "aws_instance" "web" {
  ami = "ami-0dfee6e7eb44d480b"
  associate_public_ip_address = true
  instance_type = "t2.micro"

  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp3"
  }
}