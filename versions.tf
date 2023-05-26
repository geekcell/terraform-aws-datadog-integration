terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.36"
    }
    datadog = {
      source  = "datadog/datadog"
      version = ">= 3.21"
    }
  }
}
