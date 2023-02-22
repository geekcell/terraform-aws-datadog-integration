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
