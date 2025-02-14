# ------------------------------------------------------------------------------
# Create the IAM policy that allows all of the permissions necessary
# to provision the networking layer in the Shared Services account.
# ------------------------------------------------------------------------------

data "aws_iam_policy_document" "provisionnetworking_policy_doc" {
  statement {
    actions = [
      "ec2:AllocateAddress",
      "ec2:AssociateDhcpOptions",
      "ec2:AssociateRouteTable",
      "ec2:AttachInternetGateway",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CreateDhcpOptions",
      "ec2:CreateFlowLogs",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateNetworkAcl",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateRoute",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSubnet",
      "ec2:CreateTags",
      "ec2:CreateTransitGateway",
      "ec2:CreateTransitGatewayRoute",
      "ec2:CreateTransitGatewayRouteTable",
      "ec2:CreateTransitGatewayVpcAttachment",
      "ec2:CreateVpc",
      "ec2:CreateVpcEndpoint",
      "ec2:DeleteDhcpOptions",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteNetworkAcl",
      "ec2:DeleteNetworkAclEntry",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteTransitGateway",
      "ec2:DeleteTransitGatewayRoute",
      "ec2:DeleteTransitGatewayRouteTable",
      "ec2:DeleteTransitGatewayVpcAttachment",
      "ec2:DeleteVpc",
      "ec2:DeleteVpcEndpoint",
      "ec2:Describe*",
      "ec2:DetachInternetGateway",
      "ec2:DisassociateRouteTable",
      "ec2:GetTransitGatewayRouteTableAssociations",
      "ec2:GetTransitGatewayRouteTablePropagations",
      "ec2:ModifyVpcAttribute",
      "ec2:ModifyVpcEndpoint",
      "ec2:ReleaseAddress",
      "ec2:ReplaceRoute",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:SearchTransitGatewayRoutes",
      "ram:AssociateResourceShare",
      "ram:CreateResourceShare",
      "ram:DeleteResourceShare",
      "ram:DisassociateResourceShare",
      "ram:GetResourceShares",
      "ram:GetResourceShareAssociations",
      "ram:ListResourceSharePermissions",
      "ram:TagResource",
      "ram:UpdateResourceShare",
      "route53:ChangeTagsForResource",
      "route53:CreateHostedZone",
      "route53:DeleteHostedZone",
      "route53:GetChange",
      "route53:GetHostedZone",
      "route53:ListResourceRecordSets",
      "route53:ListTagsForResource",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "logs:DeleteLogGroup",
      "logs:ListTagsLogGroup",
      "logs:PutRetentionPolicy",
    ]

    resources = [
      "arn:aws:logs:${var.aws_region}:${local.sharedservices_account_id}:log-group:vpc-flow-logs-sharedservices",
      "arn:aws:logs:${var.aws_region}:${local.sharedservices_account_id}:log-group:vpc-flow-logs-sharedservices:log-stream:",
    ]
  }
}

resource "aws_iam_policy" "provisionnetworking_policy" {
  provider = aws.sharedservicesprovisionaccount

  description = var.provisionnetworking_policy_description
  name        = var.provisionnetworking_policy_name
  policy      = data.aws_iam_policy_document.provisionnetworking_policy_doc.json
}
