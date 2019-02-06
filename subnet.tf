#Public subnet in each az

resource "aws_subnet" "gel-public-subnet" {
  count                   = "${length(var.availability_zones)}"
  vpc_id                  = "${aws_vpc.gel-vpc.id}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 8, count.index)}"   #ie "10.0.1.0/24"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags {
    "Name" = "Gel public subnet - ${element(var.availability_zones, count.index)}"
  }
}

#Private subnet in each az

resource "aws_subnet" "gel-private-subnet" {
  count                   = "${length(var.availability_zones)}"
  vpc_id                  = "${aws_vpc.gel-vpc.id}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))}" #ie "10.0.2.0/24"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "Gel private subnet - ${element(var.availability_zones, count.index)}"
  }
}

#Create associate EIP
resource "aws_eip" "gel-eip" {
  count = "${length(var.availability_zones)}"
  vpc   = true
}

#Create NAT gateway for private subnet - to be in public subnet
resource "aws_nat_gateway" "gel-nat" {
  count         = "${length(var.availability_zones)}"
  allocation_id = "${element(aws_eip.gel-eip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.gel-public-subnet.*.id, count.index)}"

  tags {
    Name = "NAT gateway for Gel private subnet - ${element(var.availability_zones, count.index)}"
  }
}
