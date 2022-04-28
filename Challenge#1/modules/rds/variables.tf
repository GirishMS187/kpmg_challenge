###############################################################################
# Variables - RDS
###############################################################################
variable "region" {
  description = "Default Region."
  type        = string
}

variable "cluster_identifier" {
  description = "The cluster identifier."
  type        = string
}

variable "engine" {
  description = "The name of the database engine to be used for this DB cluster."
  type        = string
  default     = "aurora"
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB cluster is deleted."
  type        = string
}


/* variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage."
  type        = string
} */

variable "engine_mode" {
  description = "The database engine mode."
  type        = string
  default     = "provisioned"
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The backup retention period."
  type        = number
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate with the Cluster."
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "identifier_prefix" {
  description = "Creates a unique identifier beginning with the specified prefix."
  type        = string
}

variable "instance_class" {
  description = "The instance class to use."
  type        = string
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  type        = bool
  default     = false
}

variable "private_subnets" {
  description = "A list of VPC subnet IDs."
}

variable "rds_master_username" {
  description = "The Master username."
  type        = string
}

variable "rds_master_password" {
  description = "rds_master_password."
  type        = string
}