variable "identifier" {
  type        = string
  description = "Unique identifier for the RDS instance."
}

variable "engine" {
  type        = string
  description = "Database engine: postgres, mysql, mariadb, etc."
}

variable "engine_version" {
  type        = string
  description = "Engine version (e.g. 15.4 for PostgreSQL)."
}

variable "instance_class" {
  type        = string
  description = "DB instance class (e.g. db.t3.medium)."
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in GB."
  default     = 20
}

variable "max_allocated_storage" {
  type        = number
  description = "Upper limit for autoscaling storage (0 to disable autoscaling)."
  default     = 0
}

variable "storage_type" {
  type        = string
  description = "Storage type: gp2, gp3, io1, etc."
  default     = "gp3"
}

variable "storage_encrypted" {
  type        = bool
  description = "Enable storage encryption at rest."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ARN or ID for encryption (uses default if null)."
  default     = null
}

variable "db_name" {
  type        = string
  description = "Initial database name (omit for Oracle/SQL Server naming rules)."
  default     = null
}

variable "username" {
  type        = string
  description = "Master username for the database."
}

variable "password" {
  type        = string
  description = "Master password for the database (use Secrets Manager in production)."
  sensitive   = true
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment."
  default     = true
}

variable "db_subnet_group_name" {
  type        = string
  description = "DB subnet group name (must span at least two AZs for Multi-AZ)."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "VPC security group IDs for the instance."
}

variable "backup_retention_period" {
  type        = number
  description = "Days to retain automated backups (0 to disable)."
  default     = 7
}

variable "deletion_protection" {
  type        = bool
  description = "Prevent accidental deletion via API."
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on destroy (not recommended for production)."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Additional tags for the RDS instance."
  default     = {}
}
