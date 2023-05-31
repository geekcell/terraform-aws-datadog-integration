## NAMING
variable "name" {
  description = "Name to use for resources in this module."
  type        = string
}

variable "tags" {
  default = {}
  type    = map(string)
}

## DATADOG
variable "datadog_site" {
  description = "Datadog site to use."
  default     = "datadoghq.eu"
  type        = string
}

variable "datadog_api_key" {
  description = "Pass an existing Datadog API key to write to the SecretsManager Secret."
  default     = null
  type        = string
}

## STACK
variable "stack_capabilities" {
  description = "CloudFormation capabilities required to create the stack."
  default     = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  type        = list(string)
}

variable "stack_template_url" {
  description = "URL of the CloudFormation template to use to create the stack."
  default     = "https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"
  type        = string
}

variable "stack_additional_parameters" {
  description = "Additional parameters to pass to the CloudFormation template."
  default     = {}
  type        = map(string)
}
