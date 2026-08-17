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
      Service     = var.service_name
      SubService  = var.sub_service_name
      Group       = var.group
      Environment = upper(var.environment)
      ManagedBy   = "Opsera"
    }
  }
}
