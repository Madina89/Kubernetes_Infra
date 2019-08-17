
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