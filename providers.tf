terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Default provider — primary account 472496548172
provider "aws" {
  region = var.region

  default_tags {
    tags = var.default_tags
  }
}

# Aliased provider — additional account 792373136340
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
