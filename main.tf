module "terraform_aws_s3" {
  source = "./modules/terraform-aws-s3"

  bucket_name             = var.bucket_name
  force_destroy           = var.force_destroy
  versioning_enabled      = var.versioning_enabled
  sse_algorithm           = var.sse_algorithm
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
  tags                    = var.s3_tags
}
