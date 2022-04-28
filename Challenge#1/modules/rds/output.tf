###############################################################################
# Outputs - RDS
###############################################################################
output "rds_cluster_id" {
  description = "The RDS Cluster Identifier."
  value       = aws_rds_cluster.db_cluster.id
}

output "rds_cluster_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_rds_cluster.db_cluster.endpoint
}