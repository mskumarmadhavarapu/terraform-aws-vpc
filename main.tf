resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # VPC association

  tags = local.igw_final_tags
}

# Public Subnets 
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = merge (
      local.common_tags,
      # roboshop-dev-public-subnet-east-1a

      {
          Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
      },
      var.public_subnet_tags
  ) 
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  
  tags = merge (
         local.common_tags,
         # roboshop-dev-private
         {
            Name = "${var.project}-${var.environment}-private"
         }
         var.private_route_table_tags
  )
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  
  tags = merge (
         local.common_tags,
         # roboshop-dev-public
         {
            Name = "${var.project}-${var.environment}-public"
         }
         var.public_route_table_tags
  )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  
  tags = merge (
         local.common_tags,
         # roboshop-dev-database
         {
            Name = "${var.project}-${var.environment}-database"
         }
         var.daabase_route_table_tags
  )
}