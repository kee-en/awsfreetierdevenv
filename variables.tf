# variable "ami" {
#   description = "The ID of the AMI to use for the EC2 instance"
# }

# variable "instance_type" {
#   description = "The type of EC2 instance"
# }
variable "resource_name" {
  default = "dev-env"
}

variable "env" {
  default = "development"
}

variable "owner" {
  default = "kiendolorfo@icloud.com"
}