/**
 * # Terraform AWS DataDog ECS Fargate Agent
 *
 * This module deploys a DataDog agent to an ECS Fargate cluster. Basic configuration can be done via ENV vars and
 * label configuration can be done via the `auto_discovery_checks` variable. An easy way to monitor databases without
 * having to setup an EC2 instance. For more information, see: https://docs.datadoghq.com/database_monitoring/
 */
module "ecs_agent_container" {
  source = "github.com/geekcell/terraform-aws-ecs-container-definition?ref=v1"

  name  = "datadog-agent"
  image = var.agent_container

  cpu    = var.agent_container_cpu
  memory = var.agent_container_memory

  healthcheck = var.agent_container_healthcheck
  environment = var.agent_container_environment
  secrets = merge({
    for secret in var.secretsmanager_secret_keys : secret => "${aws_secretsmanager_secret.main[0].arn}:${secret}::"
  }, var.agent_container_secrets)

  docker_labels = merge({
    "com.datadoghq.ad.checks" = jsonencode(var.auto_discovery_checks)
  }, var.agent_container_docker_labels)
}

module "ecs_task_definition" {
  source = "github.com/geekcell/terraform-aws-ecs-task-definition.git?ref=v1"

  name                   = var.name
  container_definitions  = [module.ecs_agent_container.hcl]
  enable_execute_command = var.enable_execute_command

  additional_task_role_policies    = var.task_additional_task_role_policies
  additional_execute_role_policies = var.task_additional_execute_role_policies

  operating_system_family = var.operating_system_family
  cpu_architecture        = var.cpu_architecture

  tags = var.tags
}

resource "aws_ecs_service" "main" {
  name = var.name

  launch_type            = "FARGATE"
  cluster                = var.ecs_cluster_name
  desired_count          = var.desired_count
  enable_execute_command = var.enable_execute_command
  task_definition        = module.ecs_task_definition.arn

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent         = var.deployment_maximum_percent
  force_new_deployment               = var.force_new_deployment
  wait_for_steady_state              = var.wait_for_steady_state

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  tags = var.tags
}

resource "aws_secretsmanager_secret" "main" {
  count = length(var.secretsmanager_secret_keys) > 0 ? 1 : 0

  name = "${var.name}/env"
  tags = var.tags
}

module "ecs_exec_ssm_policy" {
  count = length(var.secretsmanager_secret_keys) > 0 ? 1 : 0

  source = "github.com/geekcell/terraform-aws-iam-policy?ref=v1"

  name = "${var.name}-ssm-env"
  statements = [
    {
      sid       = "ReadSecrets"
      effect    = "Allow"
      actions   = ["secretsmanager:GetSecretValue"]
      resources = [aws_secretsmanager_secret.main[0].arn]
    }
  ]

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_exec_ssm_policy" {
  count = length(var.secretsmanager_secret_keys) > 0 ? 1 : 0

  role       = module.ecs_task_definition.execution_role_name
  policy_arn = module.ecs_exec_ssm_policy[0].arn
}
