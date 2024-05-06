# Security group for the STS interface endpoint
resource "aws_security_group" "sts_endpoint" {
  provider = aws.sharedservicesprovisionaccount

  vpc_id = aws_vpc.the_vpc.id

  tags = {
    Name = "STS endpoint"
  }
}

# Allow ingress via HTTPS from the STS endpoint client security group.
resource "aws_security_group_rule" "ingress_from_sts_endpoint_client_to_sts_endpoint_via_https" {
  provider = aws.sharedservicesprovisionaccount

  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sts_endpoint.id
  source_security_group_id = aws_security_group.sts_endpoint_client.id
  to_port                  = 443
  type                     = "ingress"
}
