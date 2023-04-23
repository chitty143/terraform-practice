locals {
    domain_names = {
        "dev" = "webserver-1"
        "prod" = "webserver-2"
    }
}


resource "aws_route53_record" "www" {

    for_each = local.domain_names
  zone_id = var.zone_id
  name    = each.key
  type    = "A"
  ttl     = "10"
  records = [
    aws_instance.web_server[each.value].private_ip
  ]
}
