<!-- BEGIN_TF_DOCS -->
# Terraform AWS DataDog Metric Stream Submodule

This module creates a Kinesis Firehose Delivery Stream and a CloudWatch Metric Stream to send metrics to Datadog.
See the [Datadog Documentation](https://docs.datadoghq.com/integrations/guide/aws-cloudwatch-metric-streams-with-kinesis-data-firehose)
for more information.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_retention_days"></a> [cloudwatch\_retention\_days](#input\_cloudwatch\_retention\_days) | Number of days to retain CloudWatch logs for the Metric Stream. | `number` | `14` | no |
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Your Datadog API key. | `string` | n/a | yes |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | The metrics endpoint URL corresponding to your Datadog site. | `string` | `"datadoghq.eu"` | no |
| <a name="input_exclude_filters"></a> [exclude\_filters](#input\_exclude\_filters) | List of exclusive metric filters. Conflicts with `include_filter`. | `list(string)` | `[]` | no |
| <a name="input_include_filters"></a> [include\_filters](#input\_include\_filters) | List of inclusive metric filters. Conflicts with `exclude_filter`. | `list(string)` | `[]` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix that will added to created resources. | `string` | n/a | yes |
| <a name="input_s3_deny_non_secure_transport"></a> [s3\_deny\_non\_secure\_transport](#input\_s3\_deny\_non\_secure\_transport) | Deny non-secure transport for S3 Metric Stream Backup bucket. | `bool` | `true` | no |
| <a name="input_s3_mfa"></a> [s3\_mfa](#input\_s3\_mfa) | MFA device ARN including a TOTP token to enable MFA delete for the S3 Metric Stream Backup bucket. | `string` | `null` | no |
| <a name="input_s3_mfa_delete"></a> [s3\_mfa\_delete](#input\_s3\_mfa\_delete) | Enable MFA Delete for the S3 Metric Stream Backup bucket. | `string` | `"Disabled"` | no |
| <a name="input_s3_noncurrent_version_expiration"></a> [s3\_noncurrent\_version\_expiration](#input\_s3\_noncurrent\_version\_expiration) | Number of days non-current versions of objects will remain in the S3 Metric Stream Backup bucket. | `number` | `30` | no |
| <a name="input_s3_versioning"></a> [s3\_versioning](#input\_s3\_versioning) | Enable S3 Versioning for the S3 Metric Stream Backup bucket. | `string` | `"Enabled"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the created resources. | `map(any)` | `{}` | no |

## Outputs

No outputs.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |

## Resources

- resource.aws_cloudwatch_log_group.main (modules/metrics_firehose/main.tf#312)
- resource.aws_cloudwatch_log_stream.http_endpoint (modules/metrics_firehose/main.tf#319)
- resource.aws_cloudwatch_log_stream.s3_backup (modules/metrics_firehose/main.tf#324)
- resource.aws_cloudwatch_metric_stream.main (modules/metrics_firehose/main.tf#107)
- resource.aws_kinesis_firehose_delivery_stream.main (modules/metrics_firehose/main.tf#261)
- resource.aws_s3_bucket.main (modules/metrics_firehose/main.tf#332)
- resource.aws_s3_bucket_acl.main (modules/metrics_firehose/main.tf#338)
- resource.aws_s3_bucket_lifecycle_configuration.main (modules/metrics_firehose/main.tf#362)
- resource.aws_s3_bucket_policy.main (modules/metrics_firehose/main.tf#375)
- resource.aws_s3_bucket_public_access_block.main (modules/metrics_firehose/main.tf#343)
- resource.aws_s3_bucket_versioning.main (modules/metrics_firehose/main.tf#352)
- data source.aws_iam_policy_document.main (modules/metrics_firehose/main.tf#382)
<!-- END_TF_DOCS -->
