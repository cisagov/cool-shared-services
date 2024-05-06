#-------------------------------------------------------------------------------
# Note that all these resources depend on the VPC, the NAT GWs, or
# both, and hence on the
# aws_iam_role_policy_attachment.provisionnetworking_policy_attachment
# resource.
# -------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Set up routing for the private subnets.
#
# The public subnets will use the default routing table in the VPC, as
# defined in public_routing.tf.
# -------------------------------------------------------------------------------

# Each private subnet gets its own routing table, since each subnet
# uses its own NAT gateway.
resource "aws_route_table" "private_route_tables" {
  provider = aws.sharedservicesprovisionaccount

  for_each = toset(var.private_subnet_cidr_blocks)

  vpc_id = aws_vpc.the_vpc.id
}

# Route all non-local COOL (outside this VPC but inside the COOL)
# traffic through the transit gateway.
resource "aws_route" "cool_routes" {
  provider = aws.sharedservicesprovisionaccount

  for_each = toset(var.private_subnet_cidr_blocks)

  destination_cidr_block = var.cool_cidr_block
  route_table_id         = aws_route_table.private_route_tables[each.value].id
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

# Route all external (outside this VPC and outside the COOL) traffic
# through the NAT gateways
resource "aws_route" "external_routes" {
  provider = aws.sharedservicesprovisionaccount

  for_each = toset(var.private_subnet_cidr_blocks)

  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private_route_tables[each.value].id
  nat_gateway_id         = aws_nat_gateway.nat_gws[each.value].id
}

# Associate the routing tables with the subnets
resource "aws_route_table_association" "private_route_table_associations" {
  provider = aws.sharedservicesprovisionaccount

  for_each = toset(var.private_subnet_cidr_blocks)

  route_table_id = aws_route_table.private_route_tables[each.value].id
  subnet_id      = module.private.subnets[each.value].id
}

# Associate the S3 gateway endpoint with each of the route tables
resource "aws_vpc_endpoint_route_table_association" "s3_private" {
  provider = aws.sharedservicesprovisionaccount

  for_each = toset(var.private_subnet_cidr_blocks)

  route_table_id  = aws_route_table.private_route_tables[each.value].id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
