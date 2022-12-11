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
