# Security group for the VPC interface endpoints in the private subnet
# that are required by the SSM agent
resource "aws_security_group" "ssm_agent_endpoint" {
  provider = aws.sharedservicesprovisionaccount

  vpc_id = aws_vpc.the_vpc.id

  tags = {
    Name = "SSM agent endpoints"
  }
}

# Allow ingress via HTTPS from the SSM endpoint agent client security group.
resource "aws_security_group_rule" "ingress_from_ssm_agent_endpoint_client_to_ssm_agent_endpoint_via_https" {
  provider = aws.sharedservicesprovisionaccount

  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ssm_agent_endpoint.id
  source_security_group_id = aws_security_group.ssm_agent_endpoint_client.id
  to_port                  = 443
  type                     = "ingress"
}
