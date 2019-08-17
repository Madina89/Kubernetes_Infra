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