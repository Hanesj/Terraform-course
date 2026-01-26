#   1. VPC ID
#   2. Public Subnets - subnet_key => { subnet_id, az}
#   3. Private Subnets - subnet_key => {subnet_id ,az}

locals {
  output_public_subnets = {
    for key in keys(local.public_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
      cidr = aws_subnet.this[key].cidr_block
    }
  }
  output_private_subnets = {
    for key in keys(local.private_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
      cidr = aws_subnet.this[key].cidr_block
    }
  }
}

output "vpc_id" {
  value       = aws_vpc.this.id
  description = "VPC ID"

}

output "public_subnets" {
  value = local.output_public_subnets
}
output "private_subnets" {
  value = local.output_private_subnets
}