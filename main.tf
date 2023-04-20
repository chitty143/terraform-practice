locals {
  instance_type = {
    "web-server-a" = "t2.micro"
    "web-server-b" = "t2.small"
    "web-server-c" = "t2.medium"
  }
}

resource "aws_instance" "web" {

  for_each      = local.instance_type
  ami           = "ami-06e46074ae430fba6"
  instance_type = each.value
  key_name      = "verginia"


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