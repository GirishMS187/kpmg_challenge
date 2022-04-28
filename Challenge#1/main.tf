module "networking" {
  source   = "./modules/networking"
  app_name = "eks-kpmg"
}

 module "eks" {
  source = "./modules/eks"
  subnet_ids = slice(module.networking.pub_sub_ids,0,3)
  app_name = "eks-cluster-kpmg"
  vpc_id=module.networking.vpc_id
} 

# DB Security Creation
module "db_security_group" {
  source                = "terraform-aws-modules/security-group/aws" # version = "3.18.0"
 
  name                  = "kpmg_${terraform.workspace}"
  description           = "Security Group ${terraform.workspace} DB Instance"
  vpc_id                = module.networking.vpc_id  
# Ingress Rules & CIDR Blocks
  ingress_rules           = ["mysql-tcp"]  
  ingress_cidr_blocks   = ["10.0.0.0/16"]
# Egress Rule - all-all open
  egress_rules          = ["all-all"]
  tags = {
    "Name"              = "kpmg_db_${terraform.workspace}"
    "Environment"       = "${terraform.workspace}"
  }
 }

 module "rds" {
   source = "./modules/rds"

   cluster_identifier        = "aurora-cluster-kpmg"
   engine                    = "aurora-mysql"
   /* engine_version            = "11.12" */
   engine_mode               = "provisioned"
   rds_master_username       = "kpmg"
   rds_master_password       = "kpmg123"
   deletion_protection       = false
   backup_retention_period   = 5
   preferred_backup_window   = "07:00-09:00"
   vpc_security_group_ids    = [module.db_security_group.security_group_id]  
   apply_immediately         = true
   final_snapshot_identifier = "delete"
   region                    = "ap-south-1"

   identifier_prefix     = "aurora-instance-kpmg"
   instance_class        = "db.r4.large"
   publicly_accessible   = false

   common_tags            = {
      Name = "aurora-cluster-girish"
      app_name = "kpmg"
      type     = "db"
      devopsowner = "girish"
      environment = "Prod"
   }
   private_subnets        = slice(module.networking.pri_sub_ids,0,3)
 }   