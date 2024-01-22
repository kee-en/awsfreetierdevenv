resource "aws_instance" "development_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = merge(var.tags, {
    Name = "${var.resource_name}-vm"
  })

  key_name = var.key_name
  vpc_security_group_ids = [ var.security_group_id ]
}
