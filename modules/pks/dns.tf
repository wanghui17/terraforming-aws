resource "aws_route53_record" "pks_api_dns" {
  zone_id = "${var.zone_id}"
  name    = "api.pks.${var.env_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = "${aws_lb.pks_api.dns_name}"
    zone_id                = "${aws_lb.pks_api.zone_id}"
    evaluate_target_health = true
  }

  count = "${var.use_route53}"
}

resource "aws_route53_record" "environment_ns_records" {
  zone_id = "Z1JAUQ3QXUF18P"
  name    = "${var.env_name}"
  type    = "NS"
  ttl     = "300"
  records = ["${module.infra.name_servers[0]}", "${module.infra.name_servers[1]}", "${module.infra.name_servers[2]}", "${module.infra.name_servers[3]}"]
}