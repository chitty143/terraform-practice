variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "ss"
}


variable "vpc_security_group_ids" {
  type    = list(any)
  default = ["sg-0aef9538b8141c147"]
}

variable "subnet_id" {
  type    = string
  default = "subnet-0041a25ca2576a15d"
}

variable "ami_id" {
  type    = string
  default = "ami-06fc49795bc410a0c"
}

variable "availability_zone" {
  type    = string
  default = "ap-south-1b"
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "tags" {
  type = map(any)
  default = {
    name        = "aws"
    application = "dev"
  }
}