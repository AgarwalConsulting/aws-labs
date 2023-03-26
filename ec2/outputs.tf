output "ip_address" {
  value = aws_instance.ubuntu[*].public_ip
}
