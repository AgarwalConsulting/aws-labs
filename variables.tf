variable "region" {
  description = "AWS region to deploy to"
  default     = "ap-south-1"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  default = "eks-101"
  type = string
}

variable "availability_zones" {
  description = "Subnet availability zone"
  default = ["ap-south-1a", "ap-south-1b"]
  type = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  default = "1.32"
  type = string
}

variable "cluster_count" {
  description = "No of clusters to create"
  default = 1
  type = number
}

variable "instance_count" {
  description = "No of instances to create"
  default = 1
  type = number
}

variable "user_emails" {
  description = "User Email IDs"
  type = list(string)
  default = [
    "gaurav@codermana.com",
    "gauravagarwalr@gmail.com"
  ]
}

variable "db_instance_size" {
  description = "The size of DB instance"
  default = "db.t3.micro"
  type = string
}

variable "db_engine_version" {
  description = "The Postgres engine version"
  default = "17.4"
  type = string
}

locals {
  db_names = ["${var.cluster_name}-db", "${var.cluster_name}-db-monitor"]
}
