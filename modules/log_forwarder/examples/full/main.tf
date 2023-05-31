module "datadog_log_forwarder" {
  source = "../../"

  name            = "datadog-log-forwarder"
  datadog_api_key = "1234567890abcdef"
}
