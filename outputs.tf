output "azs_info" {
  value     = "aws_availability_zones.available"
}

output "vpc_id" {
    value = aws_vpc.main.id
}