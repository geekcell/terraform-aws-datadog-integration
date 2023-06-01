## NAMING
variable "prefix" {
  description = "Prefix to use for resources in this module."
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

## LAMBDA
variable "lambda_function_name" {
  description = "The name of the Lambda function."
  default     = null
  type        = string
}

variable "lambda_reserved_concurrency" {
  description = "The number of concurrent executions reserved for the Lambda."
  default     = null
  type        = number
}

variable "lambda_log_retention_days" {
  description = "The number of days to retain log events for the Lambda in Cloudwatch."
  default     = 90
  type        = number
}

variable "lambda_timeout" {
  description = "The amount of time the Lambda function has to run in seconds."
  default     = 120
  type        = number
}

variable "lambda_memory_size" {
  description = "Amount of memory to allocate to the Lambda function."
  default     = 1024
  type        = number
}

## S3
variable "s3_bucket_name" {
  description = "The name of the S3 forwarder bucket to create."
  default     = null
  type        = string
}

variable "s3_versioning" {
  description = "Enable S3 Versioning for the forwarder bucket."
  default     = "Enabled"
  type        = string
}

variable "s3_noncurrent_version_expiration" {
  description = "Specifies when non-current object versions expire in the forwarder bucket."
  default     = 30
  type        = number
}

variable "s3_mfa" {
  description = "MFA device ARN including a TOTP token to enable MFA delete for the forwarder bucket."
  default     = null
  type        = string
}

variable "s3_mfa_delete" {
  description = "Enable MFA Delete for the forwarder bucket."
  default     = "Disabled"
  type        = string
}
