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

  # for_each = toset(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "11", "12", "13", "14", "15"])
  for_each = toset(["one", "two", "three"])
  name = "instance-${each.key}"

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

resource "aws_autoscaling_group" "my_asg" {
  availability_zones        = ["us-west-2a"]
  name                      = "my_asg"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = "my_web_config"
}

resource "aws_launch_configuration" "my_web_config" {
  name          = "my_web_config"
  image_id      = "ami-09b4b74c"
  instance_type = "t3.micro"
}
