output "id" {
  value = aws_instance.development_instance.id
}

output "public_ip" {
  value = aws_instance.development_instance.public_ip
}

output "subnet_id" {
  value = aws_instance.development_instance.subnet_id
}