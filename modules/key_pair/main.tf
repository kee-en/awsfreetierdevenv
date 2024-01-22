resource "aws_key_pair" "my_key_pair" {
  key_name = "${var.resource_name}-key-pair"
  public_key = file("~/.ssh/id_ed25519.pub")

  tags = var.tags
}