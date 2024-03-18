<!-- BEGIN_TF_DOCS -->
# Terraform AWS Datadog Log Forwarder Lambda Module

This Terraform module deploys the Datadog Log Forwarder Lambda function as a Cloudformation stack. This is this
recommended way by Datadog.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Pass an existing Datadog API key to write to the SecretsManager Secret. | `string` | `null` | no |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | Datadog site to use. | `string` | `"datadoghq.eu"` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | The name of the Lambda function. | `string` | `null` | no |
| <a name="input_lambda_log_retention_days"></a> [lambda\_log\_retention\_days](#input\_lambda\_log\_retention\_days) | The number of days to retain log events for the Lambda in Cloudwatch. | `number` | `90` | no |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | Amount of memory to allocate to the Lambda function. | `number` | `1024` | no |
| <a name="input_lambda_reserved_concurrency"></a> [lambda\_reserved\_concurrency](#input\_lambda\_reserved\_concurrency) | The number of concurrent executions reserved for the Lambda. | `number` | `null` | no |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | The amount of time the Lambda function has to run in seconds. | `number` | `120` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to use for resources in this module. | `string` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 forwarder bucket to create. | `string` | `null` | no |
| <a name="input_s3_mfa"></a> [s3\_mfa](#input\_s3\_mfa) | MFA device ARN including a TOTP token to enable MFA delete for the forwarder bucket. | `string` | `null` | no |
| <a name="input_s3_mfa_delete"></a> [s3\_mfa\_delete](#input\_s3\_mfa\_delete) | Enable MFA Delete for the forwarder bucket. | `string` | `"Disabled"` | no |
| <a name="input_s3_noncurrent_version_expiration"></a> [s3\_noncurrent\_version\_expiration](#input\_s3\_noncurrent\_version\_expiration) | Specifies when non-current object versions expire in the forwarder bucket. | `number` | `30` | no |
| <a name="input_s3_versioning"></a> [s3\_versioning](#input\_s3\_versioning) | Enable S3 Versioning for the forwarder bucket. | `string` | `"Enabled"` | no |
| <a name="input_stack_additional_parameters"></a> [stack\_additional\_parameters](#input\_stack\_additional\_parameters) | Additional parameters to pass to the CloudFormation template. | `map(string)` | `{}` | no |
| <a name="input_stack_capabilities"></a> [stack\_capabilities](#input\_stack\_capabilities) | CloudFormation capabilities required to create the stack. | `list(string)` | <pre>[<br>  "CAPABILITY_IAM",<br>  "CAPABILITY_NAMED_IAM",<br>  "CAPABILITY_AUTO_EXPAND"<br>]</pre> | no |
| <a name="input_stack_template_url"></a> [stack\_template\_url](#input\_stack\_template\_url) | URL of the CloudFormation template to use to create the stack. | `string` | `"https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secretsmanager_secret_arn"></a> [secretsmanager\_secret\_arn](#output\_secretsmanager\_secret\_arn) | n/a |
| <a name="output_stack_outputs"></a> [stack\_outputs](#output\_stack\_outputs) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.50 |

## Resources

- resource.aws_cloudformation_stack.main (modules/log_forwarder/main.tf#21)
- resource.aws_s3_bucket_lifecycle_configuration.main (modules/log_forwarder/main.tf#57)
- resource.aws_s3_bucket_versioning.main (modules/log_forwarder/main.tf#45)
- resource.aws_secretsmanager_secret.main (modules/log_forwarder/main.tf#7)
- resource.aws_secretsmanager_secret_version.main (modules/log_forwarder/main.tf#14)

# Examples
  ### Full
  ```hcl
  module "datadog_log_forwarder" {
  source = "../../"

  prefix          = "production-core"
  datadog_api_key = "1234567890abcdef"
}
  ```
<!-- END_TF_DOCS -->
