variable "name" {
  type = string
}

variable "tags" {
  default = {}
  type    = map(string)
}

variable "agent_container" {
  default = "public.ecr.aws/datadog/agent:latest"
  type    = string
}

variable "auto_discovery_checks" {
  default = {}
  type    = any
}

variable "agent_container_healthcheck" {
  default = {
    command      = ["CMD-SHELL", "agent health"]
    interval     = 30
    retries      = 3
    start_period = 10
    timeout      = 2
  }
  type = object({
    command      = list(string)
    interval     = number
    retries      = number
    start_period = number
    timeout      = number
  })
}

variable "agent_container_environment" {
  default = {
    DD_SITE = "datadoghq.eu"
  }
  type = map(string)
}

variable "agent_container_secrets" {
  default = {}
  type    = map(string)
}

variable "agent_container_cpu" {
  default = 256
  type    = number
}

variable "agent_container_memory" {
  default = 512
  type    = number
}

variable "task_additional_task_role_policies" {
  default = []
  type    = list(string)
}

variable "task_additional_execute_role_policies" {
  default = []
  type    = list(string)
}

variable "operating_system_family" {
  default = "LINUX"
  type    = string
}

variable "cpu_architecture" {
  default = "ARM64"
  type    = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "subnet_ids" {
  default = []
  type    = list(string)
}

variable "security_group_ids" {
  default = []
  type    = list(string)
}

variable "assign_public_ip" {
  default = false
  type    = bool
}

variable "enable_execute_command" {
  default = true
  type    = bool
}

variable "desired_count" {
  default = 1
  type    = number
}

variable "agent_container_docker_labels" {
  default = {}
  type    = map(string)
}

variable "deployment_minimum_healthy_percent" {
  default = 100
  type    = number
}

variable "deployment_maximum_percent" {
  default = 200
  type    = number
}

variable "force_new_deployment" {
  default = false
  type    = bool
}

variable "wait_for_steady_state" {
  default = true
  type    = bool
}

variable "secretsmanager_secret_keys" {
  default     = []
  description = "List of keys to retrieve from SecretsManager and inject into the container. If populated, will create a Secretsmanager Secret and IAM policy to allow the ECS task to retrieve the secret."
  type        = list(string)
}
