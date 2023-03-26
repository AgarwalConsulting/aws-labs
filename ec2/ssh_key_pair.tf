resource "aws_key_pair" "key_pair" {
  key_name   = "vnc_key_pair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

# vnc://ubuntu:training2023@35.175.63.129:5901
