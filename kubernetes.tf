
resource "aws_autoscaling_attachment" "bastions-madina-kubernetes-com" {
  elb                    = "${aws_elb.bastion-madina-kubernetes-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.bastions-madina-kubernetes-com.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-2c-masters-madina-kubernetes-com" {
  elb                    = "${aws_elb.api-madina-kubernetes-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-2c-masters-madina-kubernetes-com.id}"
}

resource "aws_autoscaling_group" "bastions-madina-kubernetes-com" {
  name                 = "bastions.madina-kubernetes.com"
  launch_configuration = "${aws_launch_configuration.bastions-madina-kubernetes-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.utility-us-east-2b-madina-kubernetes-com.id}", "${aws_subnet.utility-us-east-2c-madina-kubernetes-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "bastions.madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "bastions"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/bastion"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-us-east-2c-masters-madina-kubernetes-com" {
  name                 = "master-us-east-2c.masters.madina-kubernetes.com"
  launch_configuration = "${aws_launch_configuration.master-us-east-2c-masters-madina-kubernetes-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.us-east-2c-madina-kubernetes-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-us-east-2c.masters.madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-us-east-2c"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-madina-kubernetes-com" {
  name                 = "nodes.madina-kubernetes.com"
  launch_configuration = "${aws_launch_configuration.nodes-madina-kubernetes-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-2b-madina-kubernetes-com.id}", "${aws_subnet.us-east-2c-madina-kubernetes-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "c-etcd-events-madina-kubernetes-com" {
  availability_zone = "us-east-2c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "c.etcd-events.madina-kubernetes.com"
    "k8s.io/etcd/events"                          = "c/c"
    "k8s.io/role/master"                          = "1"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-main-madina-kubernetes-com" {
  availability_zone = "us-east-2c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "c.etcd-main.madina-kubernetes.com"
    "k8s.io/etcd/main"                            = "c/c"
    "k8s.io/role/master"                          = "1"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_eip" "us-east-2b-madina-kubernetes-com" {
  vpc = true

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "us-east-2b.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_eip" "us-east-2c-madina-kubernetes-com" {
  vpc = true

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "us-east-2c.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

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

resource "aws_iam_instance_profile" "bastions-madina-kubernetes-com" {
  name = "bastions.madina-kubernetes.com"
  role = "${aws_iam_role.bastions-madina-kubernetes-com.name}"
}

resource "aws_iam_instance_profile" "masters-madina-kubernetes-com" {
  name = "masters.madina-kubernetes.com"
  role = "${aws_iam_role.masters-madina-kubernetes-com.name}"
}

resource "aws_iam_instance_profile" "nodes-madina-kubernetes-com" {
  name = "nodes.madina-kubernetes.com"
  role = "${aws_iam_role.nodes-madina-kubernetes-com.name}"
}

resource "aws_iam_role" "bastions-madina-kubernetes-com" {
  name               = "bastions.madina-kubernetes.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_bastions.madina-kubernetes.com_policy")}"
}

resource "aws_iam_role" "masters-madina-kubernetes-com" {
  name               = "masters.madina-kubernetes.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.madina-kubernetes.com_policy")}"
}

resource "aws_iam_role" "nodes-madina-kubernetes-com" {
  name               = "nodes.madina-kubernetes.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.madina-kubernetes.com_policy")}"
}

resource "aws_iam_role_policy" "bastions-madina-kubernetes-com" {
  name   = "bastions.madina-kubernetes.com"
  role   = "${aws_iam_role.bastions-madina-kubernetes-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_bastions.madina-kubernetes.com_policy")}"
}

resource "aws_iam_role_policy" "masters-madina-kubernetes-com" {
  name   = "masters.madina-kubernetes.com"
  role   = "${aws_iam_role.masters-madina-kubernetes-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.madina-kubernetes.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-madina-kubernetes-com" {
  name   = "nodes.madina-kubernetes.com"
  role   = "${aws_iam_role.nodes-madina-kubernetes-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.madina-kubernetes.com_policy")}"
}

resource "aws_internet_gateway" "madina-kubernetes-com" {
  vpc_id = "${aws_vpc.madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-madina-kubernetes-com-03a971121e165f0d3de5b3a63278eb86" {
  key_name   = "kubernetes.madina-kubernetes.com-03:a9:71:12:1e:16:5f:0d:3d:e5:b3:a6:32:78:eb:86"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.madina-kubernetes.com-03a971121e165f0d3de5b3a63278eb86_public_key")}"
}

resource "aws_launch_configuration" "bastions-madina-kubernetes-com" {
  name_prefix                 = "bastions.madina-kubernetes.com-"
  image_id                    = "ami-0dd3b1702120579bd"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-madina-kubernetes-com-03a971121e165f0d3de5b3a63278eb86.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.bastions-madina-kubernetes-com.id}"
  security_groups             = ["${aws_security_group.bastion-madina-kubernetes-com.id}"]
  associate_public_ip_address = true

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 32
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-us-east-2c-masters-madina-kubernetes-com" {
  name_prefix                 = "master-us-east-2c.masters.madina-kubernetes.com-"
  image_id                    = "ami-0dd3b1702120579bd"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-madina-kubernetes-com-03a971121e165f0d3de5b3a63278eb86.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-madina-kubernetes-com.id}"
  security_groups             = ["${aws_security_group.masters-madina-kubernetes-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-us-east-2c.masters.madina-kubernetes.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-madina-kubernetes-com" {
  name_prefix                 = "nodes.madina-kubernetes.com-"
  image_id                    = "ami-0dd3b1702120579bd"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-madina-kubernetes-com-03a971121e165f0d3de5b3a63278eb86.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-madina-kubernetes-com.id}"
  security_groups             = ["${aws_security_group.nodes-madina-kubernetes-com.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.madina-kubernetes.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_nat_gateway" "us-east-2b-madina-kubernetes-com" {
  allocation_id = "${aws_eip.us-east-2b-madina-kubernetes-com.id}"
  subnet_id     = "${aws_subnet.utility-us-east-2b-madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "us-east-2b.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_nat_gateway" "us-east-2c-madina-kubernetes-com" {
  allocation_id = "${aws_eip.us-east-2c-madina-kubernetes-com.id}"
  subnet_id     = "${aws_subnet.utility-us-east-2c-madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "us-east-2c.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.madina-kubernetes-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.madina-kubernetes-com.id}"
}

resource "aws_route" "private-us-east-2b-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-east-2b-madina-kubernetes-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-2b-madina-kubernetes-com.id}"
}

resource "aws_route" "private-us-east-2c-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-us-east-2c-madina-kubernetes-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.us-east-2c-madina-kubernetes-com.id}"
}

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

resource "aws_route53_zone_association" "Z1QSNVXTQ9XGVG" {
  zone_id = "/hostedzone/Z1QSNVXTQ9XGVG"
  vpc_id  = "${aws_vpc.madina-kubernetes-com.id}"
}

resource "aws_route_table" "madina-kubernetes-com" {
  vpc_id = "${aws_vpc.madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/kops/role"                     = "public"
  }
}

resource "aws_route_table" "private-us-east-2b-madina-kubernetes-com" {
  vpc_id = "${aws_vpc.madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "private-us-east-2b.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/kops/role"                     = "private-us-east-2b"
  }
}

resource "aws_route_table" "private-us-east-2c-madina-kubernetes-com" {
  vpc_id = "${aws_vpc.madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "private-us-east-2c.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/kops/role"                     = "private-us-east-2c"
  }
}

resource "aws_route_table_association" "private-us-east-2b-madina-kubernetes-com" {
  subnet_id      = "${aws_subnet.us-east-2b-madina-kubernetes-com.id}"
  route_table_id = "${aws_route_table.private-us-east-2b-madina-kubernetes-com.id}"
}

resource "aws_route_table_association" "private-us-east-2c-madina-kubernetes-com" {
  subnet_id      = "${aws_subnet.us-east-2c-madina-kubernetes-com.id}"
  route_table_id = "${aws_route_table.private-us-east-2c-madina-kubernetes-com.id}"
}

resource "aws_route_table_association" "utility-us-east-2b-madina-kubernetes-com" {
  subnet_id      = "${aws_subnet.utility-us-east-2b-madina-kubernetes-com.id}"
  route_table_id = "${aws_route_table.madina-kubernetes-com.id}"
}

resource "aws_route_table_association" "utility-us-east-2c-madina-kubernetes-com" {
  subnet_id      = "${aws_subnet.utility-us-east-2c-madina-kubernetes-com.id}"
  route_table_id = "${aws_route_table.madina-kubernetes-com.id}"
}

resource "aws_security_group" "api-elb-madina-kubernetes-com" {
  name        = "api-elb.madina-kubernetes.com"
  vpc_id      = "${aws_vpc.madina-kubernetes-com.id}"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "api-elb.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_security_group" "bastion-elb-madina-kubernetes-com" {
  name        = "bastion-elb.madina-kubernetes.com"
  vpc_id      = "${aws_vpc.madina-kubernetes-com.id}"
  description = "Security group for bastion ELB"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "bastion-elb.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_security_group" "bastion-madina-kubernetes-com" {
  name        = "bastion.madina-kubernetes.com"
  vpc_id      = "${aws_vpc.madina-kubernetes-com.id}"
  description = "Security group for bastion"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "bastion.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_security_group" "masters-madina-kubernetes-com" {
  name        = "masters.madina-kubernetes.com"
  vpc_id      = "${aws_vpc.madina-kubernetes-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "masters.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_security_group" "nodes-madina-kubernetes-com" {
  name        = "nodes.madina-kubernetes.com"
  vpc_id      = "${aws_vpc.madina-kubernetes-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "nodes.madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.masters-madina-kubernetes-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.masters-madina-kubernetes-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-madina-kubernetes-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-madina-kubernetes-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.bastion-elb-madina-kubernetes-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "bastion-to-master-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.bastion-madina-kubernetes-com.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "bastion-to-node-ssh" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.bastion-madina-kubernetes-com.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-madina-kubernetes-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.api-elb-madina-kubernetes-com.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "icmp-pmtu-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-madina-kubernetes-com.id}"
  from_port         = 3
  to_port           = 4
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-madina-kubernetes-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.nodes-madina-kubernetes-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-elb-to-bastion" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.bastion-madina-kubernetes-com.id}"
  source_security_group_id = "${aws_security_group.bastion-elb-madina-kubernetes-com.id}"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "ssh-external-to-bastion-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.bastion-elb-madina-kubernetes-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "us-east-2b-madina-kubernetes-com" {
  vpc_id            = "${aws_vpc.madina-kubernetes-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "us-east-2b"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "us-east-2b.madina-kubernetes.com"
    SubnetType                                    = "Private"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_subnet" "us-east-2c-madina-kubernetes-com" {
  vpc_id            = "${aws_vpc.madina-kubernetes-com.id}"
  cidr_block        = "172.20.64.0/19"
  availability_zone = "us-east-2c"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "us-east-2c.madina-kubernetes.com"
    SubnetType                                    = "Private"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}

resource "aws_subnet" "utility-us-east-2b-madina-kubernetes-com" {
  vpc_id            = "${aws_vpc.madina-kubernetes-com.id}"
  cidr_block        = "172.20.0.0/22"
  availability_zone = "us-east-2b"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "utility-us-east-2b.madina-kubernetes.com"
    SubnetType                                    = "Utility"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_subnet" "utility-us-east-2c-madina-kubernetes-com" {
  vpc_id            = "${aws_vpc.madina-kubernetes-com.id}"
  cidr_block        = "172.20.4.0/22"
  availability_zone = "us-east-2c"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "utility-us-east-2c.madina-kubernetes.com"
    SubnetType                                    = "Utility"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
    "kubernetes.io/role/elb"                      = "1"
  }
}

resource "aws_vpc" "madina-kubernetes-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "madina-kubernetes-com" {
  domain_name         = "us-east-2.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "madina-kubernetes-com" {
  vpc_id          = "${aws_vpc.madina-kubernetes-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.madina-kubernetes-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
