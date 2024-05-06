# Security group for instances that use the STS VPC endpoint
resource "aws_security_group" "sts_endpoint_client" {
  provider = aws.sharedservicesprovisionaccount

  vpc_id = aws_vpc.the_vpc.id

  tags = {
    Name = "STS endpoint client"
  }
}

# Allow egress via HTTPS to the STS endpoint security group.
resource "aws_security_group_rule" "egress_from_sts_endpoint_client_to_sts_endpoint_via_https" {
  provider = aws.sharedservicesprovisionaccount

  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sts_endpoint_client.id
  source_security_group_id = aws_security_group.sts_endpoint.id
  to_port                  = 443
  type                     = "egress"
}
