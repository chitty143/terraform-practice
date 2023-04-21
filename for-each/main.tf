locals {
  instance_types = {
    "web-1"  = "t2.micro"
    "web-2 " = "t2.micro"
    "web-3"  = "t2.nano"
  }
}

resource "aws_instance" "test" {
  for_each      = local.instance_types
  ami           = var.ami 
  instance_type = each.value
  key_name      = var.key_name 

  user_data = <<-EOF
                     #!bin/bash
                     sudo yum update -y
                     sudo yum install -y httpd
                     systemctl enable httpd
                     systemctl start httpd
                     EOF

  tags = {
    Name = each.key
  }
}