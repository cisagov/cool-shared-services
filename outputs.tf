output "cloudwatch_agent_endpoint_client_security_group" {
  description = "A security group for any instances that run the AWS CloudWatch agent.  This security group allows such instances to communicate with the VPC endpoints that are required by the AWS CloudWatch agent."
  value       = aws_security_group.cloudwatch_agent_endpoint_client
}

output "cool_cidr_block" {
  description = "The overall CIDR block associated with the COOL."
  value       = var.cool_cidr_block
}

output "default_route_table" {
  description = "The default route table for the VPC, which is used by the public subnets."
  value       = aws_default_route_table.public
}

output "ec2_endpoint_client_security_group" {
  description = "A security group for any instances that wish to communicate with the EC2 VPC endpoint."
  value       = aws_security_group.ec2_endpoint_client
}

output "private_route_tables" {
  description = "The route tables used by the private subnets in the VPC."
  value       = aws_route_table.private_route_tables
}

output "private_subnet_nat_gws" {
  description = "The NAT gateways used in the private subnets in the VPC."
  value       = aws_nat_gateway.nat_gws
}

output "private_subnet_private_reverse_zones" {
  description = "The private Route53 reverse zones for the private subnets in the VPC."
  value       = aws_route53_zone.private_subnet_private_reverse_zones
}

output "private_subnets" {
  description = "The private subnets in the VPC."
  value       = module.private.subnets
}

output "private_zone" {
  description = "The private Route53 zone for the VPC."
  value       = aws_route53_zone.private_zone
}

output "provision_private_dns_records_role" {
  description = "The role that can provision DNS records in the private Route53 zone for the VPC."
  value       = aws_iam_role.provisionprivatednsrecords_role
}

output "public_subnet_private_reverse_zones" {
  description = "The private Route53 reverse zones for the public subnets in the VPC."
  value       = aws_route53_zone.public_subnet_private_reverse_zones
}

output "public_subnets" {
  description = "The public subnets in the VPC."
  value       = module.public.subnets
}

output "read_terraform_state" {
  description = "The IAM policies and role that allow read-only access to the cool-sharedservices-networking state in the Terraform state bucket."
  value       = module.read_terraform_state
}

output "s3_endpoint_client_security_group" {
  description = "A security group for any instances that wish to communicate with the S3 VPC endpoint."
  value       = aws_security_group.s3_endpoint_client
}

output "ssm_agent_endpoint_client_security_group" {
  description = "A security group for any instances that run the AWS SSM agent.  This security group allows such instances to communicate with the VPC endpoints that are required by the AWS SSM agent."
  value       = aws_security_group.ssm_agent_endpoint_client
}

output "ssm_endpoint_client_security_group" {
  description = "A security group for any instances that wish to communicate with the SSM VPC endpoint."
  value       = aws_security_group.ssm_endpoint_client
}

output "sts_endpoint_client_security_group" {
  description = "A security group for any instances that wish to communicate with the STS VPC endpoint."
  value       = aws_security_group.sts_endpoint_client
}

output "transit_gateway" {
  description = "The Transit Gateway that allows cross-VPC communication."
  value       = aws_ec2_transit_gateway.tgw
}

output "transit_gateway_attachment_route_tables" {
  description = "Transit Gateway route tables for each of the accounts that are allowed to attach to the Transit Gateway.  These route tables ensure that these accounts can communicate with the Shared Services account but are isolated from each other."
  value       = aws_ec2_transit_gateway_route_table.tgw_attachments
}

output "transit_gateway_principal_associations" {
  description = "The RAM resource principal associations for the Transit Gateway that allows cross-VPC communication."
  value       = aws_ram_principal_association.tgw
}

output "transit_gateway_ram_resource" {
  description = "The RAM resource share associated with the Transit Gateway that allows cross-VPC communication."
  value       = aws_ram_resource_association.tgw
}

output "transit_gateway_sharedservices_vpc_attachment" {
  description = "The Transit Gateway attachment to the Shared Services VPC."
  value       = aws_ec2_transit_gateway_vpc_attachment.tgw
}

output "vpc" {
  description = "The Shared Services VPC."
  value       = aws_vpc.the_vpc
}

output "vpc_dhcp_options" {
  description = "The DHCP options for the Shared Services VPC."
  value       = aws_vpc_dhcp_options.the_dhcp_options
}

output "vpc_dhcp_options_association" {
  description = "The DHCP options association for the Shared Services VPC."
  value       = aws_vpc_dhcp_options_association.the_dhcp_options_association
}

output "vpc_endpoint_s3" {
  description = "The S3 gateway endpoint for the Shared Services VPC."
  value       = aws_vpc_endpoint.s3
}
