<!-- BEGIN_TF_DOCS -->
# Terraform AWS DataDog ECS Fargate Agent

This module deploys a DataDog agent to an ECS Fargate cluster. Basic configuration can be done via ENV vars and
label configuration can be done via the `auto_discovery_checks` variable. An easy way to monitor databases without
having to setup an EC2 instance. For more information, see: https://docs.datadoghq.com/database_monitoring/

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_container"></a> [agent\_container](#input\_agent\_container) | n/a | `string` | `"public.ecr.aws/datadog/agent:latest"` | no |
| <a name="input_agent_container_cpu"></a> [agent\_container\_cpu](#input\_agent\_container\_cpu) | n/a | `number` | `256` | no |
| <a name="input_agent_container_docker_labels"></a> [agent\_container\_docker\_labels](#input\_agent\_container\_docker\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_agent_container_environment"></a> [agent\_container\_environment](#input\_agent\_container\_environment) | n/a | `map(string)` | <pre>{<br>  "DD_SITE": "datadoghq.eu"<br>}</pre> | no |
| <a name="input_agent_container_healthcheck"></a> [agent\_container\_healthcheck](#input\_agent\_container\_healthcheck) | n/a | <pre>object({<br>    command      = list(string)<br>    interval     = number<br>    retries      = number<br>    start_period = number<br>    timeout      = number<br>  })</pre> | <pre>{<br>  "command": [<br>    "CMD-SHELL",<br>    "agent health"<br>  ],<br>  "interval": 30,<br>  "retries": 3,<br>  "start_period": 10,<br>  "timeout": 2<br>}</pre> | no |
| <a name="input_agent_container_memory"></a> [agent\_container\_memory](#input\_agent\_container\_memory) | n/a | `number` | `512` | no |
| <a name="input_agent_container_secrets"></a> [agent\_container\_secrets](#input\_agent\_container\_secrets) | n/a | `map(string)` | `{}` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | n/a | `bool` | `false` | no |
| <a name="input_auto_discovery_checks"></a> [auto\_discovery\_checks](#input\_auto\_discovery\_checks) | n/a | `any` | `{}` | no |
| <a name="input_cpu_architecture"></a> [cpu\_architecture](#input\_cpu\_architecture) | n/a | `string` | `"ARM64"` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | n/a | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | n/a | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | n/a | `number` | `1` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | n/a | `string` | n/a | yes |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | n/a | `bool` | `true` | no |
| <a name="input_force_new_deployment"></a> [force\_new\_deployment](#input\_force\_new\_deployment) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_operating_system_family"></a> [operating\_system\_family](#input\_operating\_system\_family) | n/a | `string` | `"LINUX"` | no |
| <a name="input_secretsmanager_secret_keys"></a> [secretsmanager\_secret\_keys](#input\_secretsmanager\_secret\_keys) | List of keys to retrieve from SecretsManager and inject into the container. If populated, will create a Secretsmanager Secret and IAM policy to allow the ECS task to retrieve the secret. | `list(string)` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_task_additional_execute_role_policies"></a> [task\_additional\_execute\_role\_policies](#input\_task\_additional\_execute\_role\_policies) | n/a | `list(string)` | `[]` | no |
| <a name="input_task_additional_task_role_policies"></a> [task\_additional\_task\_role\_policies](#input\_task\_additional\_task\_role\_policies) | n/a | `list(string)` | `[]` | no |
| <a name="input_wait_for_steady_state"></a> [wait\_for\_steady\_state](#input\_wait\_for\_steady\_state) | n/a | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secretsmanager_secret_arn"></a> [secretsmanager\_secret\_arn](#output\_secretsmanager\_secret\_arn) | n/a |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.50 |

## Resources

- resource.aws_ecs_service.main (modules/fargate_agent/main.tf#44)
- resource.aws_iam_role_policy_attachment.ecs_exec_ssm_policy (modules/fargate_agent/main.tf#96)
- resource.aws_secretsmanager_secret.main (modules/fargate_agent/main.tf#71)

# Examples
### Full
```hcl
module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "~> 3.19"

  name = "main"
  cidr = "10.100.0.0/16"
}

module "ecs_cluster" {
  source = "github.com/geekcell/terraform-aws-ecs-cluster?ref=main"

  name = "my-ecs-cluster"
}

module "datadog_agent" {
  source = "../../"

  name             = "datadog-agent"
  ecs_cluster_name = module.ecs_cluster.name

  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.datadog_agent_security_group.security_group_id]

  secretsmanager_secret_keys = [
    "DD_API_KEY",

    "REDIS_HOST",
    "REDIS_PASSWORD",

    "DB_USERNAME",
    "DB_PASSWORD",
    "DB_HOST_1",
    "DB_HOST_2"
  ]

  auto_discovery_checks = {
    # Redis
    redisdb = {
      instances = [
        {
          port     = 6379
          host     = "%%env_REDIS_HOST%%"
          password = "%%env_REDIS_PASSWORD%%"
          tags     = ["cacheclusterid:my-redis-cluster"]
        }
      ]
    }

    # MySQL
    mysql = {
      instances = [
        {
          dbm      = true
          port     = 3306
          host     = "%%env_DB_HOST_1%%"
          username = "%%env_DB_USERNAME%%"
          password = "%%env_DB_PASSWORD%%"
        },
        {
          dbm      = true
          port     = 3306
          host     = "%%env_DB_HOST_2%%"
          username = "%%env_DB_USERNAME%%"
          password = "%%env_DB_PASSWORD%%"
        }
      ]
    }
  }
}

module "datadog_agent_security_group" {
  source = "github.com/geekcell/terraform-aws-security-group?ref=main"

  name   = "datadog-ecs-dd-agent"
  vpc_id = module.vpc.private_subnets

  egress_rules = [
    {
      description = "Allow HTTPS outbound traffic."
      port        = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      port        = 6379
      protocol    = "tcp"
      cidr_blocks = ["10.100.0.0/16"]
    },
    {
      port        = 3306
      protocol    = "tcp"
      cidr_blocks = ["10.100.0.0/16"]
    }
  ]
}
```
<!-- END_TF_DOCS -->
