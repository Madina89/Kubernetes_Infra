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