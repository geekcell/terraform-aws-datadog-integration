module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "main"
  cidr = "10.100.0.0/16"
}

module "ecs_cluster" {
  source = "github.com/geekcell/terraform-aws-ecs-cluster?ref=v1"

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
  source = "github.com/geekcell/terraform-aws-security-group?ref=v1"

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
