#-------------------------------------------------------------------------------
# Set up routing in the VPC for the public subnets, which use the
# VPC's default routing table.
#
# The routing for the private subnets is configured in
# private_routing.tf.
# -------------------------------------------------------------------------------

# Default route table (used by public subnets)
resource "aws_default_route_table" "public" {
  provider = aws.sharedservicesprovisionaccount

  default_route_table_id = aws_vpc.the_vpc.default_route_table_id
}

# Route all non-local COOL (outside this VPC but inside the COOL)
# traffic through the transit gateway
resource "aws_route" "cool_route" {
  provider = aws.sharedservicesprovisionaccount

  destination_cidr_block = var.cool_cidr_block
  route_table_id         = aws_default_route_table.public.id
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

# Route all external (outside this VPC and outside the COOL) traffic
# through the internet gateway
resource "aws_route" "external_route" {
  provider = aws.sharedservicesprovisionaccount

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_default_route_table.public.id
  gateway_id             = aws_internet_gateway.the_igw.id
}

# Associate the S3 gateway endpoint with the route table
resource "aws_vpc_endpoint_route_table_association" "s3_public" {
  provider = aws.sharedservicesprovisionaccount

  route_table_id  = aws_default_route_table.public.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
