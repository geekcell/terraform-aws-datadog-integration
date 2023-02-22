## NAMING
variable "name" {
  description = "Family of the task definition."
  default     = ""
  type        = string
}

variable "tags" {
  description = "Tags to add to the created resources."
  default     = {}
  type        = map(any)
}

## DATADOG
variable "datadog_site" {
  description = ""
  default     = "datadoghq.eu"
  type        = string
}

variable "datadog_api_key" {
  description = ""
  default     = "datadoghq.eu"
  type        = string
}

variable "exclude_filters" {
  description = ""
  default     = []
  type        = list(string)
}

variable "include_filters" {
  description = ""
  default     = []
  type        = list(string)
}
