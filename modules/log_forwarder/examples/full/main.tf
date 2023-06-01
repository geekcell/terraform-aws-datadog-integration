module "datadog_log_forwarder" {
  source = "../../"

  prefix          = "production-core"
  datadog_api_key = "1234567890abcdef"
}
