resource "aws_autoscaling_attachment" "bastions-madina-kubernetes-com" {
  elb                    = "${aws_elb.bastion-madina-kubernetes-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.bastions-madina-kubernetes-com.id}"
}

resource "aws_autoscaling_attachment" "master-us-east-2c-masters-madina-kubernetes-com" {
  elb                    = "${aws_elb.api-madina-kubernetes-com.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-us-east-2c-masters-madina-kubernetes-com.id}"
}