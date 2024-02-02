resource "aws_db_subnet_group" "rds_subnet_group" {
  count = local.db_count
  name       = "${var.db_names[count.index]}-subnet-group"
  subnet_ids = var.db_subnet_ids
}
