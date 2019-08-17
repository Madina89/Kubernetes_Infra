

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