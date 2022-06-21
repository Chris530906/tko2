output "r53_url" {
  value = aws_route53_record.custom.fqdn
}