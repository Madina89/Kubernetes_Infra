output "bastion_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.bastions-madina-kubernetes-com.id}"]
}

output "bastion_security_group_ids" {
  value = ["${aws_security_group.bastion-madina-kubernetes-com.id}"]
}

output "bastions_role_arn" {
  value = "${aws_iam_role.bastions-madina-kubernetes-com.arn}"
}

output "bastions_role_name" {
  value = "${aws_iam_role.bastions-madina-kubernetes-com.name}"
}

output "cluster_name" {
  value = "madina-kubernetes.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-us-east-2c-masters-madina-kubernetes-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-madina-kubernetes-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-madina-kubernetes-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-madina-kubernetes-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-madina-kubernetes-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-madina-kubernetes-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.us-east-2b-madina-kubernetes-com.id}", "${aws_subnet.us-east-2c-madina-kubernetes-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-madina-kubernetes-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-madina-kubernetes-com.name}"
}

output "region" {
  value = "us-east-2"
}

output "route_table_private-us-east-2b_id" {
  value = "${aws_route_table.private-us-east-2b-madina-kubernetes-com.id}"
}

output "route_table_private-us-east-2c_id" {
  value = "${aws_route_table.private-us-east-2c-madina-kubernetes-com.id}"
}

output "route_table_public_id" {
  value = "${aws_route_table.madina-kubernetes-com.id}"
}

output "subnet_us-east-2b_id" {
  value = "${aws_subnet.us-east-2b-madina-kubernetes-com.id}"
}

output "subnet_us-east-2c_id" {
  value = "${aws_subnet.us-east-2c-madina-kubernetes-com.id}"
}

output "subnet_utility-us-east-2b_id" {
  value = "${aws_subnet.utility-us-east-2b-madina-kubernetes-com.id}"
}

output "subnet_utility-us-east-2c_id" {
  value = "${aws_subnet.utility-us-east-2c-madina-kubernetes-com.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.madina-kubernetes-com.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.madina-kubernetes-com.id}"
}