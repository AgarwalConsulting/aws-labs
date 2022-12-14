variable "region" {
  description = "AWS region to deploy to"
  default = "us-east-1"
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

variable "cluster_count" {
  description = "No of clusters to create"
  default = 21
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
