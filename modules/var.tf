variable "instance_count" {
    type = number
    default = 1
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
    default = "kvp"
}

variable "vpc_security_group_ids" {
    type = list(any)
    default = ["sg-072e8909762265771"]
}

variable "subnet_id" {
    type = string
    default = "subnet-097135ebfb9a3fcfa"
}

variable "ami_id" {
    type = string
    default = "ami-0b0f111b5dcb2800f"
}


variable "disable_api_termination" {
    type = string
    default = false
}

variable "associate_public_ip_address" {
    type = string
    default = true
}

# variable "tags" {
#     type = map
# #    Name = "aws"
# #     application = "dev"
#}