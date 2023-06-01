# Can be configured via ENV vars. See: https://registry.terraform.io/providers/DataDog/datadog/latest/docs#optional
provider "datadog" {}
provider "aws" {}

# Enable the basic AWS integration:
# https://docs.datadoghq.com/integrations/amazon_web_services/#aws-iam-permissions
module "integration" {
  source = "../../"

  prefix = "datadog-pro"
}

# Enable metric stream integration for faster metric ingestion:
# https://docs.datadoghq.com/integrations/guide/aws-cloudwatch-metric-streams-with-kinesis-data-firehose
module "metric_stream" {
  source = "../../modules/metrics_firehose"

  prefix          = "datadog-pro"
  datadog_api_key = var.datadog_api_key
}

# Deploy the log forwarder Lambda via CloudFormation:
# https://docs.datadoghq.com/logs/guide/forwarder/?tab=terraform
module "log_forwarder" {
  source = "../../modules/log_forwarder"

  prefix          = "datadog-pro"
  datadog_api_key = var.datadog_api_key
}
