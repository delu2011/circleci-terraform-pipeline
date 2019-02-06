output "vpc_id" {
  value = "${aws_vpc.gel-vpc.id}"
}

output "public_subnets" {
  value = "${aws_subnet.gel-public-subnet.*.id}"
}

output "public_cidrs" {
  value = "${aws_subnet.gel-public-subnet.*.cidr_block}"
}

output "private_subnets" {
  value = "${aws_subnet.gel-private-subnet.*.id}"
}

output "private_cidrs" {
  value = "${aws_subnet.gel-private-subnet.*.cidr_block}"
}
