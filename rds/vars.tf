variable vpc_id {
  description = "VPC ID from which belongs the subnets"
  type        = string
}

variable "db_subnet_ids" {
  description = "Subnet IDs"
  type = list(string)
}

variable "db_names" {
  description = "The names to be given to the DBs"
  type = list(string)
}

variable "db_instance_size" {
  description = "The size of DB instance"
  type = string
}

variable "db_engine_version" {
  description = "The engine version"
  type = string
}

locals {
  db_count = length(var.db_names)
}
