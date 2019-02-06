#Create public route table
resource "aws_route_table" "gel-public-rt" {
  vpc_id = "${aws_vpc.gel-vpc.id}"

  tags {
    "Name" = "Gel public route table"
  }
}

resource "aws_route" "gel-public-ig" {
  route_table_id         = "${aws_route_table.gel-public-rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gel-ig.id}"
}

#Associate public subnet to public route table
resource "aws_route_table_association" "gel-public-ra" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.gel-public-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.gel-public-rt.id}"
}

#Create private route table
resource "aws_route_table" "gel-private-rt" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.gel-vpc.id}"

  tags {
    "Name" = "Gel private route table - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route" "gel-nat-gw" {
  count                  = "${length(var.availability_zones)}"
  route_table_id         = "${element(aws_route_table.gel-private-rt.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.gel-nat.*.id, count.index)}"
}

#Associate public subnet to public route table
resource "aws_route_table_association" "gel-private-ra" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.gel-private-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.gel-private-rt.*.id, count.index)}"
}
