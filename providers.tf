terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Grupo = var.team
      Terraform = "true"
      ManagedBy = "Opsera"
      Service = var.service_name
      Environment = upper(var.environment)
      NewRelic = "true"
    }
  }
}
