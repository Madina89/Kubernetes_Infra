

resource "aws_elb" "api-madina-kubernetes-com" {
  name = "api-madina-kubernetes-com-iqm1du"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-madina-kubernetes-com.id}"]
  subnets         = ["${aws_subnet.utility-us-east-2b-madina-kubernetes-com.id}", "${aws_subnet.utility-us-east-2c-madina-kubernetes-com.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "api.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_elb" "bastion-madina-kubernetes-com" {
  name = "bastion-madina-kubernetes-9mcg30"

  listener = {
    instance_port     = 22
    instance_protocol = "TCP"
    lb_port           = 22
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.bastion-elb-madina-kubernetes-com.id}"]
  subnets         = ["${aws_subnet.utility-us-east-2b-madina-kubernetes-com.id}", "${aws_subnet.utility-us-east-2c-madina-kubernetes-com.id}"]

  health_check = {
    target              = "TCP:22"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "bastion.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}