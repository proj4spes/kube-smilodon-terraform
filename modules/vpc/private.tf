
#  NAT Instance


resource "aws_security_group" "nat" {
  name        = "vpc_nat"
  description = "Allow traffic to pass from the private subnet to the internet"

  #count = "${ length( split(",", var.azs) ) }"
  

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks = ["${cidrsubnet(var.cidr, 8, count.index + 10)}"]
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    #cidr_blocks = ["${cidrsubnet(var.cidr, 8, count.index + 10)}"]
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "NATSG"
  }
}


#resource "aws_eip" "nat" {
#    instance = "${aws_instance.nat.id}"
#    vpc = true
#}

# Single NAT is cheaper than NAT gtwy ep
resource "aws_instance" "nat" {

  depends_on = [
#      "aws_eip.nat",
      "aws_internet_gateway.main",
  ]

  ami        = "ami-5399a435" # this is a special ami preconfigured to do NAT
  availability_zone = "eu-west-1a"
  instance_type     = "t2.micro"

  # key_name = "${var.aws_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.nat.id}"]
  subnet_id                   = "${aws_subnet.public.0.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "VPC NAT"
  }
}

resource "aws_subnet" "private" {
  count = "${ length( split(",", var.azs) ) }"

  availability_zone = "${ element( split(",", var.azs), count.index ) }"
  cidr_block = "${ cidrsubnet(var.cidr, 8, count.index + 20) }"

  vpc_id = "${ aws_vpc.main.id }"

  tags {
    "kubernetes.io/role/internal-elb" = "${ var.name }"
    builtWith = "terraform"
    KubernetesCluster = "${ var.name }"
    kz8s = "${ var.name }"
    Name = "kz8s-${ var.name }-private"
    visibility = "private"
  }
}


resource "aws_subnet" "private_etcd" {
  count = "${ length( split(",", var.azs) ) }"

  availability_zone = "${ element( split(",", var.azs), count.index ) }"
  cidr_block = "${ cidrsubnet(var.cidr, 8, count.index + 10) }"

  vpc_id = "${ aws_vpc.main.id }"

  tags {
    "kubernetes.io/role/internal-elb" = "${ var.name }"
    builtWith = "terraform"
    KubernetesCluster = "${ var.name }"
    kz8s = "${ var.name }"
    Name = "kz8s-${ var.name }-private-etcd"
    visibility = "private"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${ aws_vpc.main.id }"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${ aws_instance.nat.id }"
  }

  tags {
    builtWith = "terraform"
    KubernetesCluster = "${ var.name }"
    kz8s = "${ var.name }"
    Name = "kz8s-${ var.name }"
    visibility = "private"
  }
}

resource "aws_route_table_association" "private_etcd" {
  count = "${ length(split(",", var.azs)) }"

  route_table_id = "${ aws_route_table.private.id }"
  subnet_id = "${ element(aws_subnet.private_etcd.*.id, count.index) }"
}


resource "aws_route_table_association" "private" {
  count = "${ length(split(",", var.azs)) }"

  route_table_id = "${ aws_route_table.private.id }"
  subnet_id = "${ element(aws_subnet.private.*.id, count.index) }"
}
