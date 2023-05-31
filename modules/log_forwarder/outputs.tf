output "secretsmanager_secret_arn" {
  value = try(aws_secretsmanager_secret.main[0].arn, null)
}
