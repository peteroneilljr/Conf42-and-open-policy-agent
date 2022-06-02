terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "11", "12", "13", "14", "15", "16"])
  # for_each = toset(["one", "two", "three"])
  name     = "instance-${each.key}"

  ami                    = "ami-ebd02392"
  instance_type          = "t3.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "subnet-eddcdzz4"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}