/**
 * # Terraform AWS DataDog Module
 *
 * Terraform module that helps with various Datadog AWS integrations. This module consists of the Main module
 * for creating the AWS Integration role and the following submodules:
 *
 * ### Metric collection
 * * Metric polling (out of the box with integration role)
 * * Metric streams with Kinesis Firehose
 *
 * ### Resource collection
 * * Cloud Security Posture Management (can be enabled via the integration role)
 *
 * ### ECS Fargate Agent
 * * Scrape DB metrics for DBM
 *
 * ### Log Forwarder Lambda
 * * Forward any S3 or CloudWatch logs to Datadog
 */
data "aws_caller_identity" "current" {
  count = var.aws_account_id == null ? 1 : 0
}

locals {
  datadog_integration_role_name = "${var.prefix}-datadog-integration"
}

resource "datadog_integration_aws" "main" {
  account_id = coalesce(var.aws_account_id, data.aws_caller_identity.current[0].id)
  role_name  = local.datadog_integration_role_name

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

  name            = local.datadog_integration_role_name
  use_name_prefix = false
  description     = "Role for Datadog AWS Integration"

  policy_arns = [module.integration_policy.arn]
  assume_roles = {
    "AWS" : {
      sid         = "TrustDatadog"
      identifiers = ["arn:aws:iam::${var.datadog_aws_account_id}:root"]
      conditions = [
        {
          test     = "StringEquals"
          variable = "sts:ExternalId"
          values   = [datadog_integration_aws.main.external_id]
        }
      ]
    }
  }
}

module "integration_policy" {
  source = "github.com/geekcell/terraform-aws-iam-policy?ref=v1.0"

  name        = "${var.prefix}-datadog-integration"
  description = "Policy for Datadog AWS Integration"
  statements = [
    {
      sid    = "BucketList"
      effect = "Allow"
      actions = [
        "apigateway:GET",
        "autoscaling:Describe*",
        "backup:List*",
        "budgets:ViewBudget",
        "cloudfront:GetDistributionConfig",
        "cloudfront:ListDistributions",
        "cloudtrail:DescribeTrails",
        "cloudtrail:GetTrailStatus",
        "cloudtrail:LookupEvents",
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "codedeploy:List*",
        "codedeploy:BatchGet*",
        "directconnect:Describe*",
        "dynamodb:List*",
        "dynamodb:Describe*",
        "ec2:Describe*",
        "ecs:Describe*",
        "ecs:List*",
        "elasticache:Describe*",
        "elasticache:List*",
        "elasticfilesystem:DescribeFileSystems",
        "elasticfilesystem:DescribeTags",
        "elasticfilesystem:DescribeAccessPoints",
        "elasticloadbalancing:Describe*",
        "elasticmapreduce:List*",
        "elasticmapreduce:Describe*",
        "es:ListTags",
        "es:ListDomainNames",
        "es:DescribeElasticsearchDomains",
        "events:CreateEventBus",
        "fsx:DescribeFileSystems",
        "fsx:ListTagsForResource",
        "health:DescribeEvents",
        "health:DescribeEventDetails",
        "health:DescribeAffectedEntities",
        "kinesis:List*",
        "kinesis:Describe*",
        "kms:GetKeyRotationStatus",
        "lambda:GetPolicy",
        "lambda:List*",
        "logs:DeleteSubscriptionFilter",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams",
        "logs:DescribeSubscriptionFilters",
        "logs:FilterLogEvents",
        "logs:PutSubscriptionFilter",
        "logs:TestMetricFilter",
        "organizations:Describe*",
        "organizations:List*",
        "rds:Describe*",
        "rds:List*",
        "redshift:DescribeClusters",
        "redshift:DescribeLoggingStatus",
        "route53:List*",
        "s3:GetBucketLogging",
        "s3:GetBucketLocation",
        "s3:GetBucketNotification",
        "s3:GetBucketTagging",
        "s3:ListAllMyBuckets",
        "s3:PutBucketNotification",
        "ses:Get*",
        "sns:List*",
        "sns:Publish",
        "sqs:ListQueues",
        "states:ListStateMachines",
        "states:DescribeStateMachine",
        "support:DescribeTrustedAdvisor*",
        "support:RefreshTrustedAdvisorCheck",
        "tag:GetResources",
        "tag:GetTagKeys",
        "tag:GetTagValues",
        "wafv2:GetLoggingConfiguration",
        "xray:BatchGetTraces",
        "xray:GetTraceSummaries",
      ]
      resources = ["*"]
    }
  ]

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "csp" {
  count = var.cspm_resource_collection_enabled ? 1 : 0

  role       = module.integration_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}
