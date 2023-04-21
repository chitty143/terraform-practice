
resource "aws_ebs_volume" "volume" {
  availability_zone = "ap-south-1b"
  size              = 15
  type = "gp3"

  tags = {
    Name = "ebs"
  }
 }



  resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   =  aws_ebs_volume.volume.id
  instance_id = aws_instance.test[0].id
}


resource "aws_instance" "test" {
  count                       = var.instance_count
  ami                         = var.ami_id                      #"ami-06fc49795bc410a0c"
  key_name                    = aws_key_pair.kp.key_name        #"ss"
  instance_type               = var.instance_type               #"t2.micro"
  vpc_security_group_ids      = var.vpc_security_group_ids      #["sg-0aef9538b8141c147"]
  subnet_id                   = var.subnet_id                   #"subnet-0041a25ca2576a15d"
  availability_zone           = var.availability_zone           #"ap-south-1b"
  disable_api_termination     = var.disable_api_termination     #false
  associate_public_ip_address = var.associate_public_ip_address # true
  tags                        = var.tags
  #   {
  #     Name        = "aws"
  #     application = "dev"
  #   }
}


resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = var.key_name # Create a "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.kp.key_name}.pem"
  content  = tls_private_key.pk.private_key_pem
}


