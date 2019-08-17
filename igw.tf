
resource "aws_internet_gateway" "madina-kubernetes-com" {
  vpc_id = "${aws_vpc.madina-kubernetes-com.id}"

  tags = {
    KubernetesCluster                             = "madina-kubernetes.com"
    Name                                          = "madina-kubernetes.com"
    "kubernetes.io/cluster/madina-kubernetes.com" = "owned"
  }
}