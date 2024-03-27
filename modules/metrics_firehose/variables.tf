## NAMING
variable "prefix" {
  description = "Prefix that will added to created resources."
  type        = string
}

variable "tags" {
  description = "Tags to add to the created resources."
  default     = {}
  type        = map(any)
}

## DATADOG
variable "datadog_api_key" {
  description = "Your Datadog API key."
  type        = string
}

variable "datadog_site" {
  description = "The metrics endpoint URL corresponding to your Datadog site."
  default     = "datadoghq.eu"
  type        = string
}

variable "exclude_filters" {
  description = "List of exclusive metric filters. Conflicts with `include_filter`."
  default     = []
  type        = list(string)
}

variable "include_filters" {
  description = "List of inclusive metric filters. Conflicts with `exclude_filter`."
  default     = []
  type        = list(string)
}

## CLOUDWATCH METRIC STREAM
variable "cloudwatch_retention_days" {
  description = "Number of days to retain CloudWatch logs for the Metric Stream."
  default     = 14
  type        = number
}

## S3 METRIC STREAM BACKUP
variable "s3_versioning" {
  description = "Enable S3 Versioning for the S3 Metric Stream Backup bucket."
  default     = "Enabled"
  type        = string
}

variable "s3_noncurrent_version_expiration" {
  description = "Number of days non-current versions of objects will remain in the S3 Metric Stream Backup bucket."
  default     = 30
  type        = number
}

variable "s3_deny_non_secure_transport" {
  description = "Deny non-secure transport for S3 Metric Stream Backup bucket."
  default     = true
  type        = bool
}

variable "s3_mfa" {
  description = "MFA device ARN including a TOTP token to enable MFA delete for the S3 Metric Stream Backup bucket."
  default     = null
  type        = string
}

variable "s3_mfa_delete" {
  description = "Enable MFA Delete for the S3 Metric Stream Backup bucket."
  default     = "Disabled"
  type        = string
}

variable "use_name_prefix" {
  description = "Use name prefix for IAM roles."
  default     = true
  type        = bool
}
