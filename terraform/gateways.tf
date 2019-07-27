
resource "aws_internet_gateway" "dchat-env-gw" {
  vpc_id = "${aws_vpc.dchat-vpc.id}"
  tags {
    Name = "dchat-env-gw"
  }
}