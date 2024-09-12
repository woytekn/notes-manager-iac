variable "cluster_name" {
  type = string
  description = "Name of the ECS cluster"
}

variable "vpc_id" {
  type = string
  description = "VPC ID where ECS cluster is deployed"
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
  description = "RDS database username"
}

variable "db_password" {
  type        = string
  description = "RDS database password"
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
