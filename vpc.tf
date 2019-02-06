resource "aws_vpc" "gel-vpc" {
  cidr_block = "${var.cidr_block}"

  tags {
    Name = "Gel VPC"
  }
}

#Create internet gateway
resource "aws_internet_gateway" "gel-ig" {
  vpc_id = "${aws_vpc.gel-vpc.id}"

  tags {
    Name = "Gel internet gateway"
  }
}
