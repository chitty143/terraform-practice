variable "ami_id" {
  type    = string
  default = "ami-007855ac798b5175e"

}



variable "key_name" {
  type    = string
  default = "yes"
}

variable "zone_id" {
    type = string
    default = "Z0605240XL8Y3K07KDDA"
  
}

variable "instance_type" {
  type = map
  default = {
    "webserver-1" = "t2.micro"
 "webserver-2" = "t2.small"
  }  
      }

      