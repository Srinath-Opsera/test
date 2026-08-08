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
      Servicio = var.service_name
      Grupo = var.team
      Entorno = upper(var.environment)
      Propietario = var.team
      Contacto = var.team
      Plataforma = "Opsera"
      GestionadoPor = "Opsera"
      NuevoRelic = "true"
      Terraform = "true"
    }
  }
}
