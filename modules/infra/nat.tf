resource "aws_route_table" "deployment" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_security_group" "nat_security_group" {
  count = "${var.internetless ? 0 : 1}"
  name        = "nat_security_group"
  description = "NAT Security Group"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags, 
    {"Name" = "${var.env_name}-nat-security-group"}
    )
}

resource "aws_nat_gateway" "nat" {
  count = length(var.availability_zones)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)

  tags = merge(
    var.tags, 
    { "Name" =  "${var.env_name}-nat${count.index}" }
  )
}

resource "aws_eip" "nat_eip" {
  count = "${var.internetless ? 0 : length(var.availability_zones)}"

  vpc = true

  tags = "${var.tags}"
}

resource "aws_route" "toggle_internet" {
  count = "${var.internetless ? 0 : length(var.availability_zones)}"

  route_table_id         = "${element(aws_route_table.deployment.*.id, count.index)}"
  nat_gateway_id         = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
}
