<!-- BEGIN_TF_DOCS -->
# Terraform AWS DataDog Metric Stream Submodule

This module creates a Kinesis Firehose Delivery Stream and a CloudWatch Metric Stream to send metrics to Datadog.
See the [Datadog Documentation](https://docs.datadoghq.com/integrations/guide/aws-cloudwatch-metric-streams-with-kinesis-data-firehose)
for more information.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Your Datadog API key. | `string` | n/a | yes |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | The metrics endpoint URL corresponding to your Datadog site. | `string` | `"datadoghq.eu"` | no |
| <a name="input_exclude_filters"></a> [exclude\_filters](#input\_exclude\_filters) | List of exclusive metric filters. Conflicts with `include_filter`. | `list(string)` | `[]` | no |
| <a name="input_include_filters"></a> [include\_filters](#input\_include\_filters) | List of inclusive metric filters. Conflicts with `exclude_filter`. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Prefix or name that will added to created resources. | `string` | `"datadog"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the created resources. | `map(any)` | `{}` | no |

## Outputs

No outputs.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |

## Resources

- resource.aws_cloudwatch_log_group.main (modules/metric_stream/main.tf#308)
- resource.aws_cloudwatch_log_stream.http_endpoint (modules/metric_stream/main.tf#315)
- resource.aws_cloudwatch_log_stream.s3_backup (modules/metric_stream/main.tf#320)
- resource.aws_cloudwatch_metric_stream.main (modules/metric_stream/main.tf#103)
- resource.aws_kinesis_firehose_delivery_stream.main (modules/metric_stream/main.tf#257)
- resource.aws_s3_bucket.main (modules/metric_stream/main.tf#328)
- resource.aws_s3_bucket_acl.main (modules/metric_stream/main.tf#334)
- resource.aws_s3_bucket_public_access_block.main (modules/metric_stream/main.tf#339)
<!-- END_TF_DOCS -->
