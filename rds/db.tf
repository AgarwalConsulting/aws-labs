resource "random_string" "db_username" {
  count = local.db_count
  length           = 16
  special          = false
}

resource "random_string" "db_password" {
  count = local.db_count
  length           = 16
  special          = false
}

resource "aws_db_instance" "rds_instance" {
  count = local.db_count

  allocated_storage      = 20
  identifier             = var.db_names[count.index]
  instance_class         = var.db_instance_size
  engine                 = "postgres"
  engine_version         = var.db_engine_version
  username               = random_string.db_username[count.index].result
  password               = random_string.db_password[count.index].result
  publicly_accessible    = true
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_sg[count.index].id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group[count.index].id
}
