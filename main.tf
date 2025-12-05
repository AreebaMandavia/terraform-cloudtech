provider "aws" {
  region = "us-east-1"
}

# ---------------------
# VPC
# ---------------------
resource "aws_vpc" "assignment_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Assignment-VPC"
  }
}

# ---------------------
# Subnet
# ---------------------
resource "aws_subnet" "assignment_subnet" {
  vpc_id                  = aws_vpc.assignment_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Assignment-Subnet"
  }
}

# ---------------------
# Security Group
# ---------------------
resource "aws_security_group" "assignment_sg" {
  name        = "assignment-sg"
  description = "Allow SSH traffic"
  vpc_id      = aws_vpc.assignment_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Assignment-SG"
  }
}

# ---------------------
# EC2 Instance
# ---------------------
resource "aws_instance" "demo_server" {
  ami                    = "ami-0c2b8ca1dad447f8a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.assignment_subnet.id
  vpc_security_group_ids = [aws_security_group.assignment_sg.id]

  tags = {
    Name = "Assignment-EC2"
  }
}

# ---------------------
# S3 Bucket
# ---------------------
resource "aws_s3_bucket" "assignment_bucket" {
  bucket = "assignment-storage-bucket-areeba"
  tags = {
    Name = "Assignment-S3"
  }
}

# ---------------------
# OUTPUTS
# ---------------------
output "ec2_public_ip" {
  value = aws_instance.demo_server.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.assignment_bucket.bucket
}
