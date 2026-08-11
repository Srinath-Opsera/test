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
      Service = var.service_name
      Team = var.team
      Environment = upper(var.environment)
      Owner = var.team
      Contact = var.team
      Platform = "Opsera"
      ManagedBy = "Opsera"
      NewRelic = "true"
      Terraform = "true"
    }
  }
}
