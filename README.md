<!-- BEGIN_TF_DOCS -->
[![Geek Cell GmbH](https://raw.githubusercontent.com/geekcell/.github/main/geekcell-github-banner.png)](https://www.geekcell.io/)

### Code Quality
[![License](https://img.shields.io/github/license/geekcell/terraform-aws-datadog-integration)](https://github.com/geekcell/terraform-aws-datadog-integration/blob/master/LICENSE)
[![GitHub release (latest tag)](https://img.shields.io/github/v/release/geekcell/terraform-aws-datadog-integration?logo=github&sort=semver)](https://github.com/geekcell/terraform-aws-datadog-integration/releases)
[![Release](https://github.com/geekcell/terraform-aws-datadog-integration/actions/workflows/release.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-datadog-integration/actions/workflows/release.yaml)
[![Validate](https://github.com/geekcell/terraform-aws-datadog-integration/actions/workflows/validate.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-datadog-integration/actions/workflows/validate.yaml)
[![Lint](https://github.com/geekcell/terraform-aws-datadog-integration/actions/workflows/linter.yaml/badge.svg)](https://github.com/geekcell/terraform-aws-datadog-integration/actions/workflows/linter.yaml)

<!--
Comment in these badges if they apply to the repository.

### Security
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=INFRASTRUCTURE+SECURITY)

#### Cloud
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+AWS+V1.2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_aws_13)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+AWS+V1.3)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_azure)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+AZURE+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_azure_13)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+AZURE+V1.3)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_gcp)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+GCP+V1.1)

##### Container
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_kubernetes_16)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+KUBERNETES+V1.6)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_eks_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+EKS+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_gke_11)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+GKE+V1.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/cis_kubernetes)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=CIS+KUBERNETES+V1.5)

#### Data protection
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/soc2)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=SOC2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/pci)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=PCI-DSS+V3.2)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/pci_dss_v321)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=PCI-DSS+V3.2.1)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/iso)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=ISO27001)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/nist)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=NIST-800-53)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/hipaa)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=HIPAA)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/geekcell/terraform-aws-datadog-integration/fedramp_moderate)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=geekcell%2Fterraform-aws-datadog-integration&benchmark=FEDRAMP+%28MODERATE%29)

-->

# Terraform AWS DataDog Module

Terraform module that helps with various Datadog AWS integrations. This module consists of the Main module
for creating the AWS Integration role and the following submodules:

### Metric collection
* Metric polling (out of the box with integration role)
* Metric streams with Kinesis Firehose

### Resource collection
* Cloud Security Posture Management (can be enabled via the integration role)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_specific_namespace_rules"></a> [account\_specific\_namespace\_rules](#input\_account\_specific\_namespace\_rules) | Enables or disables metric collection for specific AWS namespaces for this AWS account only. | `map(bool)` | `null` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | AWS Account ID to integrate with DataDog. If left empty, the current account will be used. | `string` | `null` | no |
| <a name="input_cspm_resource_collection_enabled"></a> [cspm\_resource\_collection\_enabled](#input\_cspm\_resource\_collection\_enabled) | If enabled, will add the Cloud Security Posture Management policy to the integration role and enable Datadog to collect the information. | `bool` | `false` | no |
| <a name="input_datadog_aws_account_id"></a> [datadog\_aws\_account\_id](#input\_datadog\_aws\_account\_id) | AWS Account ID of DataDog. | `string` | `"464622532012"` | no |
| <a name="input_excluded_regions"></a> [excluded\_regions](#input\_excluded\_regions) | An array of AWS regions to exclude from metrics collection. | `list(string)` | `null` | no |
| <a name="input_filter_tags"></a> [filter\_tags](#input\_filter\_tags) | Array of EC2 tags (in the form key:value) defines a filter that Datadog uses when collecting metrics from EC2. Wildcards, such as ? (for single characters) and * (for multiple characters) can also be used. Only hosts that match one of the defined tags will be imported into Datadog. | `list(string)` | `null` | no |
| <a name="input_host_tags"></a> [host\_tags](#input\_host\_tags) | Array of tags (in the form key:value) to add to all hosts and metrics reporting through this integration. | `list(string)` | `null` | no |
| <a name="input_metrics_collection_enabled"></a> [metrics\_collection\_enabled](#input\_metrics\_collection\_enabled) | Whether Datadog collects metrics for this AWS account. | `bool` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix that will added to created resources. | `string` | n/a | yes |
| <a name="input_resource_collection_enabled"></a> [resource\_collection\_enabled](#input\_resource\_collection\_enabled) | Whether Datadog collects a standard set of resources from your AWS account. | `bool` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to the created resources. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datadog_integration_role_arn"></a> [datadog\_integration\_role\_arn](#output\_datadog\_integration\_role\_arn) | The ARN of the IAM role created for Datadog to integrate with AWS. |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.36 |
| <a name="provider_datadog"></a> [datadog](#provider\_datadog) | >= 3.21 |

## Resources

- resource.aws_iam_role_policy_attachment.csp (main.tf#151)
- resource.datadog_integration_aws.main (main.tf#22)
- data source.aws_caller_identity.current (main.tf#14)

# Examples
### Full
```hcl
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
```
<!-- END_TF_DOCS -->
