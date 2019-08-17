
resource "aws_route53_record" "api-madina-kubernetes-com" {
  name = "api.madina-kubernetes.com"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-madina-kubernetes-com.dns_name}"
    zone_id                = "${aws_elb.api-madina-kubernetes-com.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z1QSNVXTQ9XGVG"
}

resource "aws_route53_record" "bastion-madina-kubernetes-com" {
  name = "bastion.madina-kubernetes.com"
  type = "A"

  alias = {
    name                   = "${aws_elb.bastion-madina-kubernetes-com.dns_name}"
    zone_id                = "${aws_elb.bastion-madina-kubernetes-com.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/Z1QSNVXTQ9XGVG"
}