# Security group for the SSM interface endpoint (and other endpoints
# required when using the SSM service) in the private subnet
resource "aws_security_group" "ssm_endpoint" {
  provider = aws.sharedservicesprovisionaccount

  vpc_id = aws_vpc.the_vpc.id

  tags = {
    Name = "SSM endpoint"
  }
}

# Allow ingress via HTTPS from the SSM endpoint client security group.
resource "aws_security_group_rule" "ingress_from_ssm_endpoint_client_to_ssm_endpoint_via_https" {
  provider = aws.sharedservicesprovisionaccount

  security_group_id        = aws_security_group.ssm_endpoint.id
  type                     = "ingress"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ssm_endpoint_client.id
  from_port                = 443
  to_port                  = 443
}
