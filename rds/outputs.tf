output "db_connection_strings" {
  value = [
      for i in range(local.db_count) : "postgres://${random_string.db_username[i].result}:${random_string.db_password[i].result}@${aws_db_instance.rds_instance[i].endpoint}/postgres"
  ]
}
