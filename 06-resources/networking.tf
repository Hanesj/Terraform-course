locals {
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "06-resources"
    Name      = "06-resources"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = merge(local.common_tags, {
    Name = "06-resources-public"
  })
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"

  tags = local.common_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = local.common_tags
}

resource "aws_route_table_association" "main_rtb" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id

}

resource "aws_security_group" "public_traffic" {
  description = "Sec group for http traffic"
  name        = "public traffic"
  vpc_id      = aws_vpc.main.id

}
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_security_group" "private_traffic" {
  description = "Sec group for private traffice"
  name = "private traffic"
  vpc_id = aws_vpc.main.id
}
resource "aws_vpc_security_group_ingress_rule" "postgres" {
    security_group_id = aws_security_group.private_traffic.id
    cidr_ipv4 = "10.0.0.0/24"
    from_port = 5432
    to_port = 5432
    ip_protocol = "tcp"
  
}
resource "aws_vpc_security_group_egress_rule" "postgres" {
    security_group_id = aws_security_group.private_traffic.id
    cidr_ipv4 = "10.0.0.0/24"
    from_port = 5432
    to_port = 5432
    ip_protocol = "tcp"
  
}