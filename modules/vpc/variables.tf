variable "cidr_block" {
  type = string
  description = "CIDR block for the VPC"
}

variable "vpc_name" {
  type = string
  description = "The name of the VPC"
}

variable "public_subnet_count" {
  type = number
  description = "Number of public subnets"
}

variable "private_subnet_count" {
  type = number
  description = "Number of private subnets"
}

variable "public_subnet_cidrs" {
  type = list(string)
  description = "CIDRs for the public subnets"
}

variable "private_subnet_cidrs" {
  type = list(string)
  description = "CIDRs for the private subnets"
}

variable "availability_zones" {
  type = list(string)
  description = "List of availability zones"
}
