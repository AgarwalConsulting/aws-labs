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
  default = ["us-east-1a", "us-east-1b"]
  type = list(string)
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS cluster"
  default = "1.28"
  type = string
}

variable "cluster_count" {
  description = "No of clusters to create"
  default = 2
  type = number
}

variable "instance_count" {
  description = "No of instances to create"
  default = 16
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
  default = "15.3"
  type = string
}

locals {
  db_names = ["${var.cluster_name}-db", "${var.cluster_name}-db-monitor"]
}
