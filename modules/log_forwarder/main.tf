/**
 * # Terraform AWS Datadog Log Forwarder Lambda Module
 *
 * This Terraform module deploys the Datadog Log Forwarder Lambda function as a Cloudformation stack. This is this
 * recommended way by Datadog.
 */
resource "aws_secretsmanager_secret" "main" {
  name        = "${var.name}/api-key"
  description = "Encrypted Datadog API Key."

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "main" {
  count = var.datadog_api_key != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = var.datadog_api_key
}

resource "aws_cloudformation_stack" "main" {
  name         = var.name
  capabilities = var.stack_capabilities
  template_url = var.stack_template_url

  parameters = merge({
    DdApiKeySecretArn = aws_secretsmanager_secret.main.arn
    DdSite            = "<code class=\"js-region-param region-param\" data-region-param=\"${var.datadog_site}\"></code>"
    FunctionName      = var.name
  }, var.stack_additional_parameters)

  tags = var.tags
}
