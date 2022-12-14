variable "user_emails" {
  description = "User Email IDs"
  type = list(string)
}

variable "eks_cluster_name" {
  description = "The name of the EKS cluster"
  type = string
}

locals {
  # user_count = 20
  user_count = length(var.user_emails)
}
