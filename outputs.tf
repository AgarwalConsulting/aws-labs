output "participant_creds" {
  value = module.user_accounts.participant_creds
  sensitive = true
}

output "cluster_names" {
  value = module.eks_cluster_and_worker_nodes.cluster_names
}

output "instance_ips" {
  value = module.ec2_instances.ip_address
}

output "db_connection_strings" {
  value = module.rds_with_subnet.db_connection_strings
}
