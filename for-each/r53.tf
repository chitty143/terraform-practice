locals {
  domain_names = {
    "dev" = "web-1"
    "pro" = "web-2"
    "env" = "web-3"
  }
}


resource "aws_route53_record" "example" {
    
  for_each = local.domain_names

  zone_id  = var.zone_id #Z0605240XL8Y3K07KDDA
  name     = each.key
  type     = "A"
  ttl      = 10

  records = [
    aws_instance.test[each.value].private_ip
  ]
}