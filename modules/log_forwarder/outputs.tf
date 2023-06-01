output "secretsmanager_secret_arn" {
  value = aws_secretsmanager_secret.main.arn
}

output "stack_outputs" {
  value = aws_cloudformation_stack.main.outputs
}
