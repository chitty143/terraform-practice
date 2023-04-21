module "test" {
  source         = "../modules"
  instance_count = 1
  instance_type  = "t2.nano"
  key_name       = "kvp"
  tags = {
    Name = "aws"
  }
}