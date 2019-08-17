resource "aws_key_pair" "kubernetes-madina-kubernetes-com-03a971121e165f0d3de5b3a63278eb86" {
  key_name   = "kubernetes.madina-kubernetes.com-03:a9:71:12:1e:16:5f:0d:3d:e5:b3:a6:32:78:eb:86"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.madina-kubernetes.com-03a971121e165f0d3de5b3a63278eb86_public_key")}"
}