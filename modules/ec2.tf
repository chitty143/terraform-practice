data "aws_ebs_volume" "ebs_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "tag:Name"
    values = ["dev-*"]
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = data.aws_ebs_volume.ebs_volume.id
  instance_id = aws_instance.test[0].id
}


resource "aws_instance" "test" {
  count                       = var.instance_count
  ami                         = var.ami_id  #"ami-069aabeee6f53e7bf"
  key_name                    = var.key_name
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids   #["sg-03584007d461f71da"]
  subnet_id                   = var.subnet_id  #"subnet-0db636f5d108d6375"
  disable_api_termination     = var.disable_api_termination
  associate_public_ip_address = var.associate_public_ip_address
#   tags = { 
#     Name = "aws"
#     application = "dev"
#   }
}



resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "kvp"       # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.kp.key_name}.pem"
  content = tls_private_key.pk.private_key_pem
}


