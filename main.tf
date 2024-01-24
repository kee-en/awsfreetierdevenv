provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "ubuntu_lts" {
  most_recent = true

  # Filter by owner ID as Ubuntu AMIs may have conflicting names across regions
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "key_pair" {
  source        = "./modules/key_pair"
  resource_name = var.resource_name
  tags          = { env = var.env, owner = var.owner }
}

module "security_group" {
  source = "./modules/security_group"

  resource_name = var.resource_name
  tags = {
    env   = var.env,
    owner = var.owner
  }
}

module "ec2_instance" {
  source            = "./modules/ec2_instance"
  resource_name     = var.resource_name
  security_group_id = module.security_group.id
  ami               = data.aws_ami.ubuntu_lts.id
  instance_type     = "t2.micro"
  key_name          = module.key_pair.name
  tags = {
    env   = var.env,
    owner = var.owner
  }
}

module "network_interface" {
  source = "./modules/network_interface"

  instance_id       = module.ec2_instance.id
  subnet_id         = module.ec2_instance.subnet_id
  security_group_id = module.security_group.id
  tags = {
    env   = var.env,
    owner = var.owner
  }
}

module "elastic_ip" {
  source = "./modules/elastic_ip"

  instance_id = module.ec2_instance.id
  tags = {
    env   = var.env,
    owner = var.owner
  }
}
