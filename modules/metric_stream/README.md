<!-- BEGIN_TF_DOCS -->


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | n/a | `string` | `"datadoghq.eu"` | no |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | # DATADOG | `string` | `"datadoghq.eu"` | no |
| <a name="input_exclude_filters"></a> [exclude\_filters](#input\_exclude\_filters) | n/a | `list(string)` | `[]` | no |
| <a name="input_include_filters"></a> [include\_filters](#input\_include\_filters) | n/a | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Family of the task definition. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the created resources. | `map(any)` | `{}` | no |

## Outputs

No outputs.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |

## Resources

- resource.aws_cloudwatch_log_group.main (modules/metric_stream/main.tf#301)
- resource.aws_cloudwatch_log_stream.http_endpoint (modules/metric_stream/main.tf#308)
- resource.aws_cloudwatch_log_stream.s3_backup (modules/metric_stream/main.tf#313)
- resource.aws_cloudwatch_metric_stream.main (modules/metric_stream/main.tf#96)
- resource.aws_kinesis_firehose_delivery_stream.main (modules/metric_stream/main.tf#250)
- resource.aws_s3_bucket.main (modules/metric_stream/main.tf#321)
- resource.aws_s3_bucket_acl.main (modules/metric_stream/main.tf#327)
- resource.aws_s3_bucket_public_access_block.main (modules/metric_stream/main.tf#332)
<!-- END_TF_DOCS -->
