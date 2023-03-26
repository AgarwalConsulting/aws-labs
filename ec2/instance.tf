resource "aws_instance" "ubuntu" {
  count         = var.instance_count
  ami           = "ami-02eb7a4783e7e9317" # Ubuntu 20.04 LTS (ap-south-1 region)
  # instance_type = "c5.xlarge"           # 4 vCPUs, 8 GB RAM
  instance_type = "c5.large"           # 2 vCPUs, 4 GB RAM

  key_name          = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.vnc_access.id]

  user_data = templatefile("${path.module}/vmsetup.tpl", {})

  tags = {
    name = "go-training"
  }
}
