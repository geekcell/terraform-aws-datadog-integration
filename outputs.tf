output "datadog_integration_role_arn" {
  description = "The ARN of the IAM role created for Datadog to integrate with AWS."
  value       = module.integration_role.arn
}
