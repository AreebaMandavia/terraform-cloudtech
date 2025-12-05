terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

provider "null" {}

# ---------------------
# Simulated VPC
# ---------------------
resource "null_resource" "assignment_vpc" {
  triggers = {
    cidr_block = "10.0.0.0/16"
    name       = "Assignment-VPC"
  }

  provisioner "local-exec" {
    command = "echo 'Created simulated VPC: Assignment-VPC (CIDR 10.0.0.0/16)'"
  }
}

# ---------------------
# Simulated Subnet
# ---------------------
resource "null_resource" "assignment_subnet" {
  triggers = {
    cidr_block = "10.0.1.0/24"
    name       = "Assignment-Subnet"
  }

  provisioner "local-exec" {
    command = "echo 'Created simulated Subnet: Assignment-Subnet (CIDR 10.0.1.0/24)'"
  }
}

# ---------------------
# Simulated Security Group
# ---------------------
resource "null_resource" "assignment_sg" {
  triggers = {
    name        = "assignment-sg"
    description = "Allow SSH traffic"
  }

  provisioner "local-exec" {
    command = "echo 'Created simulated Security Group: assignment-sg (SSH allowed)'"
  }
}

# ---------------------
# Simulated EC2 Instance
# ---------------------
resource "null_resource" "demo_server" {
  triggers = {
    ami           = "ami-simulated"
    instance_type = "t2.micro"
    name          = "Assignment-EC2"
  }

  provisioner "local-exec" {
    command = "echo 'Launched simulated EC2 Instance: Assignment-EC2 (t2.micro)'"
  }
}

# ---------------------
# Simulated S3 Bucket
# ---------------------
resource "null_resource" "assignment_bucket" {
  triggers = {
    name = "assignment-storage-bucket-areeba"
  }

  provisioner "local-exec" {
    command = "echo 'Created simulated S3 Bucket: assignment-storage-bucket-areeba'"
  }
}

# ---------------------
# OUTPUTS
# ---------------------
output "ec2_public_ip" {
  value = "203.0.113.10 (simulated)"
}

output "s3_bucket_name" {
  value = "assignment-storage-bucket-areeba"
}
