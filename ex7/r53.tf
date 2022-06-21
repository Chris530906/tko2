resource "aws_route53_record" "custom" {
  zone_id = "Z07605863FXFXEAZ3C81M"
  name    = var.sandbox_id
  type    = "CNAME"
  ttl     = "5"
  records = [var.alb_dns]
}