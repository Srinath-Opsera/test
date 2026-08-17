region = "us-east-1"

bucket_name             = "affinity1-colors-dev"
force_destroy           = false
versioning_enabled      = false
sse_algorithm           = "AES256"
block_public_acls       = true
block_public_policy     = true
ignore_public_acls      = true
restrict_public_buckets = true

s3_tags = {}
service_name = "Belcorp Platform"
group = "affinity1"
environment = "dev"
sub_service_name = "colors"
