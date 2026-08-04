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
    tags = var.default_tags
  }
}

provider "aws" {
  alias  = "acct_792373136340"
  region = var.region

  assume_role {
    role_arn    = var.assume_role_arn_acct_792373136340
    external_id = var.assume_role_external_id_acct_792373136340 != "" ? var.assume_role_external_id_acct_792373136340 : null
  }

  default_tags {
    tags = var.default_tags
  }
}
