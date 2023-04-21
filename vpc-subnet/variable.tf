variable "public_subnet_cidr" {
  type    = string
  default = "172.31.96.0/20"
}


variable "private_subnet_cidr" {
  type    = string
  default = "172.31.112.0/20"
}

# variable "availability_zone_" {
#   type    = list(string)
#   default = ["us-east-1a"]
# }
variable "environment" {
  type    = string
  default = "web"
}

variable "region_number" {
  type = string
  default = "us-east-1a"
}
variable "availability_zone" {
  type = string
  default =  "us-east-1a"
}

variable "private_route_table_id" {
  type = string
  default = "rtb-027a1e1f5ad7537ce"
}