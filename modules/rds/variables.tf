variable "allocated_storage" {
  type = number
  description = "The amount of allocated storage for the RDS instance"
}

variable "engine" {
  type = string
  description = "The database engine (e.g., postgres, mysql)"
}

variable "engine_version" {
  type = string
  description = "The version of the database engine"
}

variable "instance_class" {
  type = string
  description = "The instance type for RDS (e.g., db.t2.micro for free tier)"
}

variable "db_name" {
  type = string
  description = "The name of the database"
}

variable "username" {
  type = string
  description = "The master username for the database"
}

variable "password" {
  type = string
  description = "The master password for the database"
}

variable "security_group_ids" {
  type = list(string)
  description = "List of security group IDs for the RDS instance"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs for RDS"
}
