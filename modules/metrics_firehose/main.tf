/**
 * # Terraform AWS DataDog Metric Stream Submodule
 *
 * This module creates a Kinesis Firehose Delivery Stream and a CloudWatch Metric Stream to send metrics to Datadog.
 * See the [Datadog Documentation](https://docs.datadoghq.com/integrations/guide/aws-cloudwatch-metric-streams-with-kinesis-data-firehose)
 * for more information.
 */
module "firehose_role" {
  source = "github.com/geekcell/terraform-aws-iam-role?ref=v1.0"

  name        = "${var.prefix}-datadog-firehose"
  description = "Role for Datadog Kinesis Firehose Metric Streams."
  policy_arns = [module.firehose_policy.arn]
  assume_roles = {
    "Service" : {
      identifiers = ["firehose.amazonaws.com"]
    }
  }

  tags = var.tags
}

module "firehose_policy" {
  source = "github.com/geekcell/terraform-aws-iam-policy?ref=v1.0"

  name        = "${var.prefix}-datadog-firehose"
  description = "Policy for Datadog Kinesis Firehose Metric Streams."
  statements = [
    {
      sid    = "BucketList"
      effect = "Allow"
      actions = [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ]
      resources = [aws_s3_bucket.main.arn]
    },
    {
      sid    = "BucketWrite"
      effect = "Allow"
      actions = [
        "s3:AbortMultipartUpload",
        "s3:GetObject",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ]
      resources = ["${aws_s3_bucket.main.arn}/*"]
    },
    {
      sid    = "CloudwatchWrite"
      effect = "Allow"
      actions = [
        "logs:PutLogEvents"
      ]
      resources = [aws_cloudwatch_log_group.main.arn]
    }
  ]

  tags = var.tags
}

#
# METRIC STREAM ROLE
#
module "metric_stream_role" {
  source = "github.com/geekcell/terraform-aws-iam-role?ref=v1.0"

  name        = "${var.prefix}-datadog-metric-stream"
  description = "Role for Datadog Metric Stream."
  policy_arns = [module.metric_stream_policy.arn]
  assume_roles = {
    "Service" : {
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }
  }

  tags = var.tags
}

module "metric_stream_policy" {
  source = "github.com/geekcell/terraform-aws-iam-policy?ref=v1.0"

  name        = "${var.prefix}-datadog-metric-stream"
  description = "Policy for Datadog Metric Stream."
  statements = [
    {
      sid    = "FirehoseWrite"
      effect = "Allow"
      actions = [
        "firehose:PutRecord",
        "firehose:PutRecordBatch"
      ]
      resources = [aws_kinesis_firehose_delivery_stream.main.arn]
    }
  ]

  tags = var.tags
}

#
# CW METRIC STREAM
#
resource "aws_cloudwatch_metric_stream" "main" {
  name          = "${var.prefix}-datadog"
  role_arn      = module.metric_stream_role.arn
  firehose_arn  = aws_kinesis_firehose_delivery_stream.main.arn
  output_format = "opentelemetry0.7"

  dynamic "exclude_filter" {
    for_each = var.exclude_filters

    content {
      namespace = exclude_filter.value
    }
  }

  dynamic "include_filter" {
    for_each = var.include_filters

    content {
      namespace = include_filters.value
    }
  }

  statistics_configuration {
    additional_statistics = ["p50", "p90", "p95", "p99"]

    include_metric {
      namespace   = "AWS/ApplicationELB"
      metric_name = "TargetResponseTime"
    }
  }

  statistics_configuration {
    additional_statistics = ["p95", "p99"]

    include_metric {
      namespace   = "AWS/ELB"
      metric_name = "Latency"
    }

    include_metric {
      namespace   = "AWS/ELB"
      metric_name = "TargetResponseTime"
    }
  }

  statistics_configuration {
    additional_statistics = ["p50", "p90", "p95", "p99", "p99.9"]

    include_metric {
      namespace   = "AWS/S3"
      metric_name = "FirstByteLatency"
    }

    include_metric {
      namespace   = "AWS/S3"
      metric_name = "TotalRequestLatency"
    }
  }

  statistics_configuration {
    additional_statistics = ["p90", "p95", "p99"]

    include_metric {
      namespace   = "AWS/ApiGateway"
      metric_name = "IntegrationLatency"
    }

    include_metric {
      namespace   = "AWS/ApiGateway"
      metric_name = "Latency"
    }
  }

  statistics_configuration {
    additional_statistics = ["p95", "p99"]

    include_metric {
      namespace   = "AWS/States"
      metric_name = "ExecutionTime"
    }

    include_metric {
      namespace   = "AWS/States"
      metric_name = "LambdaFunctionRunTime"
    }

    include_metric {
      namespace   = "AWS/States"
      metric_name = "LambdaFunctionScheduleTime"
    }

    include_metric {
      namespace   = "AWS/States"
      metric_name = "LambdaFunctionTime"
    }

    include_metric {
      namespace   = "AWS/States"
      metric_name = "ActivityRunTime"
    }

    include_metric {
      namespace   = "AWS/States"
      metric_name = "ActivityScheduleTime"
    }

    include_metric {
      namespace   = "AWS/States"
      metric_name = "ActivityTime"
    }
  }

  statistics_configuration {
    additional_statistics = ["p50", "p90", "p95", "p99", "p99.9"]

    include_metric {
      namespace   = "AWS/Lambda"
      metric_name = "Duration"
    }
  }

  statistics_configuration {
    additional_statistics = ["p50", "p99"]

    include_metric {
      namespace   = "AWS/Lambda"
      metric_name = "PostRuntimeExtensionsDuration"
    }
  }

  statistics_configuration {
    additional_statistics = ["p90"]

    include_metric {
      namespace   = "AWS/AppSync"
      metric_name = "Latency"
    }
  }

  statistics_configuration {
    additional_statistics = ["p50", "p95", "p99"]

    include_metric {
      namespace   = "AWS/AppRunner"
      metric_name = "RequestLatency"
    }
  }

  tags = var.tags
}

#
# KINESES FIREHOSE STREAMS
#
resource "aws_kinesis_firehose_delivery_stream" "main" {
  name        = "${var.prefix}-datadog-metric-stream"
  destination = "http_endpoint"

  s3_configuration {
    bucket_arn          = aws_s3_bucket.main.arn
    buffer_size         = 4
    buffer_interval     = 60
    compression_format  = "GZIP"
    role_arn            = module.firehose_role.arn
    error_output_prefix = "datadog-stream"

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.main.name
      log_stream_name = aws_cloudwatch_log_stream.s3_backup.name
    }
  }

  http_endpoint_configuration {
    name               = "Datadog"
    url                = "https://awsmetrics-intake.${var.datadog_site}/v1/input"
    access_key         = var.datadog_api_key
    buffering_size     = 4
    buffering_interval = 60
    retry_duration     = 60
    s3_backup_mode     = "FailedDataOnly"
    role_arn           = module.firehose_role.arn

    request_configuration {
      content_encoding = "GZIP"
    }

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.main.name
      log_stream_name = aws_cloudwatch_log_stream.http_endpoint.name
    }
  }

  server_side_encryption {
    enabled  = true
    key_type = "AWS_OWNED_CMK"
  }

  tags = var.tags
}

#
# CLOUDWATCH LOG GROUP FOR KINESIS
#
resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/kinesis/${var.prefix}-datadog-metric-stream"
  retention_in_days = var.cloudwatch_retention_days

  tags = var.tags
}

resource "aws_cloudwatch_log_stream" "http_endpoint" {
  name           = "http-endpoint-delivery"
  log_group_name = aws_cloudwatch_log_group.main.name
}

resource "aws_cloudwatch_log_stream" "s3_backup" {
  name           = "s3-backup"
  log_group_name = aws_cloudwatch_log_group.main.name
}

#
# S3 BUCKET FOR KINESIS
#
resource "aws_s3_bucket" "main" {
  bucket = "${var.prefix}-datadog-metric-stream-backup"

  tags = var.tags
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  mfa    = var.s3_mfa

  versioning_configuration {
    status     = var.s3_versioning
    mfa_delete = var.s3_mfa_delete
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_s3_bucket.main.bucket

  rule {
    id     = "expire-non-current-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = var.s3_noncurrent_version_expiration
    }
  }
}

resource "aws_s3_bucket_policy" "main" {
  count = var.s3_deny_non_secure_transport ? 1 : 0

  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.main[0].json
}

data "aws_iam_policy_document" "main" {
  count = var.s3_deny_non_secure_transport ? 1 : 0

  statement {
    actions = ["s3:*"]
    effect  = "Deny"
    sid     = "DenyNonSecureTransport"

    resources = [
      aws_s3_bucket.main.arn,
      "${aws_s3_bucket.main.arn}/*"
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}
