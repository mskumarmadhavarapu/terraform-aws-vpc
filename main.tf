resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tendancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "manual-vpc"
  }
}