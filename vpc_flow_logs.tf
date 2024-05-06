#-------------------------------------------------------------------------------
# Turn on flow logs for the VPC.
#-------------------------------------------------------------------------------
module "vpc_flow_logs" {
  providers = {
    aws = aws.sharedservicesprovisionaccount
  }
  source  = "trussworks/vpc-flow-logs/aws"
  version = "~>2.0"

  logs_retention = "365"
  vpc_id         = aws_vpc.the_vpc.id
  vpc_name       = "sharedservices"
}
