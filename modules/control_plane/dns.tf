resource "aws_route53_record" "control_plane" {
  zone_id = "${var.zone_id}"
  name    = "plane.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_lb.control_plane.dns_name}"]
}

resource "aws_route53_record" "uaa" {
  zone_id = "${var.zone_id}"
  name    = "uaa.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  // TODO
  records = ["${aws_lb.credhub_uaa.dns_name}"]
}

resource "aws_route53_record" "credhub" {
  zone_id = "${var.zone_id}"
  name    = "credhub.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  // TODO
  records = ["${aws_lb.credhub_uaa.dns_name}"]
}
