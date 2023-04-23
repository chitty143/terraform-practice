provider "aws" {
  region  = "us-east-1"
  profile = "chitty"
}


terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = "1.4.5"
}




locals {
    instance_types = {
  "webserver-1" = "t2.micro"
 "webserver-2" = "t2.small"
    }
}


resource "aws_instance" "web_server" {
  for_each      = local.instance_types
  ami           = var.ami_id   
  instance_type = each.value
  key_name      = var.key_name
 
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install -y httpd
                sudo systemctl start httpd.service
                sudo systemctl enable httpd.service
                EOF
  
  tags = {
    Name = each.key
  }
}