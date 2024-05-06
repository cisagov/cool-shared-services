# Security group for the EC2 interface endpoint in the private subnet
resource "aws_security_group" "ec2_endpoint" {
  provider = aws.sharedservicesprovisionaccount

  vpc_id = aws_vpc.the_vpc.id

  tags = {
    Name = "EC2 endpoint"
  }
}

# Allow ingress via HTTPS from the EC2 endpoint client security group
resource "aws_security_group_rule" "ingress_from_ec2_endpoint_client_to_ec2_endpoint_via_https" {
  provider = aws.sharedservicesprovisionaccount

  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_endpoint.id
  source_security_group_id = aws_security_group.ec2_endpoint_client.id
  to_port                  = 443
  type                     = "ingress"
}
