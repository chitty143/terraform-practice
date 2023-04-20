locals {
  domain_names = {
    "dev" = "web-server-a"
    "pro" = "web-server-b"
    "web" = "web-server-c"
  }
}


resource "aws_route53_record" "www" {
  for_each = local.domain_names
  zone_id  = var.zone_id
  name     = each.key
  type     = "A"
  ttl      = 10


  records = [
    aws_instance.web[each.value].public_ip
  ]
}