<!-- BEGIN_TF_DOCS -->
# Terraform AWS Datadog Log Forwarder Lambda Module

This Terraform module deploys the Datadog Log Forwarder Lambda function as a Cloudformation stack. This is this
recommended way by Datadog.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datadog_api_key"></a> [datadog\_api\_key](#input\_datadog\_api\_key) | Pass an existing Datadog API key to write to the SecretsManager Secret. | `string` | `null` | no |
| <a name="input_datadog_site"></a> [datadog\_site](#input\_datadog\_site) | Datadog site to use. | `string` | `"datadoghq.eu"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use for resources in this module. | `string` | n/a | yes |
| <a name="input_stack_additional_parameters"></a> [stack\_additional\_parameters](#input\_stack\_additional\_parameters) | Additional parameters to pass to the CloudFormation template. | `map(string)` | `{}` | no |
| <a name="input_stack_capabilities"></a> [stack\_capabilities](#input\_stack\_capabilities) | CloudFormation capabilities required to create the stack. | `list(string)` | <pre>[<br>  "CAPABILITY_IAM",<br>  "CAPABILITY_NAMED_IAM",<br>  "CAPABILITY_AUTO_EXPAND"<br>]</pre> | no |
| <a name="input_stack_template_url"></a> [stack\_template\_url](#input\_stack\_template\_url) | URL of the CloudFormation template to use to create the stack. | `string` | `"https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secretsmanager_secret_arn"></a> [secretsmanager\_secret\_arn](#output\_secretsmanager\_secret\_arn) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.50 |

## Resources

- resource.aws_cloudformation_stack.main (modules/log_forwarder/main.tf#21)
- resource.aws_secretsmanager_secret.main (modules/log_forwarder/main.tf#7)
- resource.aws_secretsmanager_secret_version.main (modules/log_forwarder/main.tf#14)

# Examples
### Full
```hcl
module "datadog_log_forwarder" {
  source = "../../"

  name            = "datadog-log-forwarder"
  datadog_api_key = "1234567890abcdef"
}
```
<!-- END_TF_DOCS -->
