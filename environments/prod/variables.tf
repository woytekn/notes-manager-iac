variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  default = "prod-vpc"
}

variable "public_subnet_count" {
  type = number
  default = 2
}

variable "private_subnet_count" {
  type = number
  default = 2
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "availability_zones" {
  type = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "cluster_name" {
  type = string
  default = "prod-cluster"
}

variable "allocated_storage" {
  type = number
  default = 20
}

variable "rds_engine" {
  type = string
  default = "postgres"
}

variable "rds_engine_version" {
  type = string
  default = "13"
}

variable "rds_instance_class" {
  type = string
  default = "db.t2.micro"
}

variable "rds_db_name" {
  type = string
  default = "prod_db"
}

variable "rds_username" {
  type = string
  default = "admin"
}

variable "rds_password" {
  type = string
  default = "password123"
}

variable "fe_image" {
  type        = string
  description = "Docker image URI for the front-end"
}

variable "be_image" {
  type        = string
  description = "Docker image URI for the back-end"
}

variable "db_host" {
  type        = string
  description = "RDS database endpoint"
}

variable "db_user" {
  type        = string
  default     = "admin"  # Upewnij się, że to jest zgodne z tym, co podałeś dla bazy danych
}

variable "db_password" {
  type        = string
  default     = "password123"  # To powinno pasować do wartości w konfiguracji RDS
}

variable "execution_role_arn" {
  type        = string
  description = "ARN of the ECS execution role"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the ECS services"
  default     = []
}
