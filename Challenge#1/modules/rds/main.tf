###############################################################################
# RDS
###############################################################################
resource "aws_rds_cluster" "db_cluster" {
  cluster_identifier        = var.cluster_identifier
  engine                    = var.engine
  /* engine_version            = var.engine_version */
  engine_mode               = var.engine_mode
  master_username           = var.rds_master_username
  master_password           = var.rds_master_password
  deletion_protection       = var.deletion_protection
  backup_retention_period   = var.backup_retention_period
  preferred_backup_window   = var.preferred_backup_window
  vpc_security_group_ids    = var.vpc_security_group_ids
  apply_immediately         = var.apply_immediately
  final_snapshot_identifier = var.final_snapshot_identifier
  db_subnet_group_name      = aws_db_subnet_group.subnet_group.id

  tags = var.common_tags
}

resource "aws_rds_cluster_instance" "db_instance" {
  identifier_prefix    = var.identifier_prefix
  cluster_identifier   = aws_rds_cluster.db_cluster.id
  instance_class       = var.instance_class
  engine               = aws_rds_cluster.db_cluster.engine
  engine_version       = aws_rds_cluster.db_cluster.engine_version
  publicly_accessible  = var.publicly_accessible

  tags = var.common_tags
}

resource "aws_db_subnet_group" "subnet_group" {
  name        = "subnet_group"
  description = "Subnet Group for the RDS"

  subnet_ids = var.private_subnets
}