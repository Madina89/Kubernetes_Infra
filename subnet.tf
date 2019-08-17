

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