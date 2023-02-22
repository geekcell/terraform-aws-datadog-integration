/**
 * # Terraform AWS DataDog Module
 *
 * Terraform module that helps integrating DataDog with AWS.
 */
data "aws_iam_account_alias" "current" {
  count = var.aws_account_id == null ? 1 : 0
}

resource "datadog_integration_aws" "main" {
  account_id = coalesce(var.aws_account_id, data.aws_iam_account_alias.current[0].id)
  role_name  = module.integration_role.name

  account_specific_namespace_rules = var.account_specific_namespace_rules
  excluded_regions                 = var.excluded_regions
  filter_tags                      = var.filter_tags
  host_tags                        = var.host_tags

  cspm_resource_collection_enabled = var.cspm_resource_collection_enabled
  metrics_collection_enabled       = var.metrics_collection_enabled
  resource_collection_enabled      = var.resource_collection_enabled
}

module "integration_role" {
  source = "github.com/geekcell/terraform-aws-iam-role?ref=v1.0"

  name        = "${var.name}-integration"
  description = "Role for Datadog AWS Integration"

  policy_arns = [module.integration_policy.arn]
  assume_roles = {
    "AWS" : {
      identifiers = ["arn:aws:iam::${var.datadog_aws_account_id}:root"]
      conditions = [
        {
          test     = "StringEquals"
          variable = "sts:ExternalId"
          values   = [coalesce(var.aws_account_id, data.aws_iam_account_alias.current[0].id)]
        }
      ]
    }
  }
}

module "integration_policy" {
  source = "github.com/geekcell/terraform-aws-iam-policy?ref=v1.0"

  name        = "${var.name}-integration"
  description = "Policy for Datadog AWS Integration"
  templates = [
    {
      name = "datadog/complete"
    }
  ]

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "csp" {
  count = var.cspm_resource_collection_enabled ? 1 : 0

  role       = module.integration_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
