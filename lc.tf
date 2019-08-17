
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
  instance_type               = "${var.master_instance_type}"
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
  instance_type               = "${var.node_instance_type}"
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