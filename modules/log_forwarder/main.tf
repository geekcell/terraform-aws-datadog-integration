/**
 * # Terraform AWS Datadog Log Forwarder Lambda Module
 *
 * This Terraform module deploys the Datadog Log Forwarder Lambda function as a Cloudformation stack. This is this
 * recommended way by Datadog.
 */
resource "aws_secretsmanager_secret" "main" {
  name        = "${var.prefix}-datadog-log-forwarder/api-key"
  description = "Encrypted Datadog API Key."

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "main" {
  count = var.datadog_api_key != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = var.datadog_api_key
}

resource "aws_cloudformation_stack" "main" {
  name         = "${var.prefix}-datadog-log-forwarder"
  capabilities = var.stack_capabilities
  template_url = var.stack_template_url

  parameters = merge({
    # Datadog
    DdApiKeySecretArn = aws_secretsmanager_secret.main.arn
    DdSite            = var.datadog_site

    # Lambda
    FunctionName        = coalesce(var.lambda_function_name, "${var.prefix}-datadog-log-forwarder")
    MemorySize          = var.lambda_memory_size
    Timeout             = var.lambda_timeout
    LogRetentionInDays  = var.lambda_log_retention_days
    ReservedConcurrency = var.lambda_reserved_concurrency

    # Bucket
    DdForwarderBucketName = coalesce(var.s3_bucket_name, "${var.prefix}-datadog-log-forwarder")
  }, var.stack_additional_parameters)

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_cloudformation_stack.main.outputs.ForwarderBucketName
  mfa    = var.s3_mfa

  versioning_configuration {
    status     = var.s3_versioning
    mfa_delete = var.s3_mfa_delete
  }

  depends_on = [aws_cloudformation_stack.main]
}

resource "aws_s3_bucket_lifecycle_configuration" "main" {
  bucket = aws_cloudformation_stack.main.outputs.ForwarderBucketName

  rule {
    id     = "expire-non-current-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = var.s3_noncurrent_version_expiration
    }
  }

  depends_on = [aws_cloudformation_stack.main]
}
