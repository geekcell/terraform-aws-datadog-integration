## NAMING
variable "name" {
  description = "Family of the task definition."
  type        = string
}

variable "tags" {
  description = "Tags to add to the created resources."
  default     = {}
  type        = map(any)
}

## DATADOG
variable "datadog_aws_account_id" {
  description = "AWS Account ID of DataDog."
  default     = "464622532012"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID to integrate with DataDog. If left empty, the current account will be used."
  default     = null
  type        = string
}

variable "account_specific_namespace_rules" {
  description = "Enables or disables metric collection for specific AWS namespaces for this AWS account only."
  default     = null
  type        = map(bool)
}

variable "excluded_regions" {
  description = "An array of AWS regions to exclude from metrics collection."
  default     = null
  type        = list(string)
}

variable "filter_tags" {
  description = "Array of EC2 tags (in the form key:value) defines a filter that Datadog uses when collecting metrics from EC2. Wildcards, such as ? (for single characters) and * (for multiple characters) can also be used. Only hosts that match one of the defined tags will be imported into Datadog."
  default     = null
  type        = list(string)
}

variable "host_tags" {
  description = "Array of tags (in the form key:value) to add to all hosts and metrics reporting through this integration."
  default     = null
  type        = list(string)
}

variable "metrics_collection_enabled" {
  description = "Whether Datadog collects metrics for this AWS account."
  default     = null
  type        = bool
}

variable "resource_collection_enabled" {
  description = "Whether Datadog collects a standard set of resources from your AWS account."
  default     = null
  type        = bool
}

variable "cspm_resource_collection_enabled" {
  description = "If enabled, will add the Cloud Security Posture Management policy to the integration role and enable Datadog to collect the information."
  default     = false
  type        = bool
}
