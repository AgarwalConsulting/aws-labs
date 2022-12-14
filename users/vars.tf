variable "user_emails" {
  description = "User Email IDs"
  type = list(string)
}

locals {
  # user_count = 20
  user_count = length(var.user_emails)
}
