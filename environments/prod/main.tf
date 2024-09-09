module "vpc" {
  source = "../../modules/vpc"
  cidr_block = var.vpc_cidr
  vpc_name   = var.vpc_name
  public_subnet_count = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "ecs" {
  source = "../../modules/ecs"
  cluster_name     = var.cluster_name
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnet_ids  
  fe_image         = var.fe_image
  be_image         = var.be_image
  db_host          = var.db_host
  db_user          = var.rds_username
  db_password      = var.db_password
  execution_role_arn = var.execution_role_arn
}

module "rds" {
  source = "../../modules/rds"
  allocated_storage   = var.allocated_storage
  engine              = var.rds_engine
  engine_version      = var.rds_engine_version
  instance_class      = var.rds_instance_class
  db_name             = var.rds_db_name
  username            = var.rds_username
  password            = var.rds_password
  security_group_ids  = [module.ecs.be_security_group_id]
  subnet_ids          = module.vpc.private_subnet_ids  
}
