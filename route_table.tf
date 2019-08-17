
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