

resource "aws_autoscaling_group" "nodes-madina-kubernetes-com" {
  name                 = "nodes.madina-kubernetes.com"
  launch_configuration = "${aws_launch_configuration.nodes-madina-kubernetes-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.us-east-2b-madina-kubernetes-com.id}", "${aws_subnet.us-east-2c-madina-kubernetes-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.madina-kubernetes.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}