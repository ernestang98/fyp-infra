resource "aws_vpc" "fyp-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "fyp-vpc"
  }
}

resource "aws_internet_gateway" "fyp-igw" {
  vpc_id = aws_vpc.fyp-vpc.id
}

resource "aws_route_table" "fyp-rt" {
  vpc_id = aws_vpc.fyp-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.fyp-igw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.fyp-igw.id
  }
  tags = {
    Name = "fyp-rt"
  }
}

resource "aws_subnet" "fyp-subnet-1" {
  vpc_id                  = aws_vpc.fyp-vpc.id
  cidr_block              = var.subnet_prefix[0].cidr_block
  availability_zone       = var.subnet_prefix[0].az
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_prefix[0].name
  }
}

resource "aws_subnet" "fyp-subnet-2" {
  vpc_id                  = aws_vpc.fyp-vpc.id
  cidr_block              = var.subnet_prefix[1].cidr_block
  availability_zone       = var.subnet_prefix[1].az
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_prefix[1].name
  }
}

resource "aws_subnet" "fyp-subnet-3" {
  vpc_id                  = aws_vpc.fyp-vpc.id
  cidr_block              = var.subnet_prefix[2].cidr_block
  availability_zone       = var.subnet_prefix[2].az
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_prefix[2].name
  }
}

resource "aws_route_table_association" "fyp-rta-subnet-1" {
  subnet_id      = aws_subnet.fyp-subnet-1.id
  route_table_id = aws_route_table.fyp-rt.id
}

resource "aws_route_table_association" "fyp-rta-subnet-2" {
  subnet_id      = aws_subnet.fyp-subnet-2.id
  route_table_id = aws_route_table.fyp-rt.id
}

resource "aws_route_table_association" "fyp-rta-subnet-3" {
  subnet_id      = aws_subnet.fyp-subnet-3.id
  route_table_id = aws_route_table.fyp-rt.id
}

resource "aws_security_group" "fyp-sg" {
  name        = "allow_web_traffic"
  description = "Allow inbound web traffic"
  vpc_id      = aws_vpc.fyp-vpc.id
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "NFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "fyp-sg"
  }
}

resource "aws_network_interface" "fyp-nic-1-subnet-1" {
  subnet_id       = aws_subnet.fyp-subnet-1.id
  private_ips     = ["10.0.1.51"]
  security_groups = [aws_security_group.fyp-sg.id]
}

resource "aws_network_interface" "fyp-nic-1-subnet-2" {
  subnet_id       = aws_subnet.fyp-subnet-2.id
  private_ips     = ["10.0.2.51"]
  security_groups = [aws_security_group.fyp-sg.id]
}

resource "aws_network_interface" "fyp-nic-1-subnet-3" {
  subnet_id       = aws_subnet.fyp-subnet-3.id
  private_ips     = ["10.0.3.51"]
  security_groups = [aws_security_group.fyp-sg.id]
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "fyp-keypair" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}
