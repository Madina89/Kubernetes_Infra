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


