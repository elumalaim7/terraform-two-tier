resource "aws_vpc" "customvpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "customvpc"
        Terraform = true
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.customvpc.id}"

    tags = {
        Name = "igw"
        Terraform = true
    }
}

resource "aws_eip" "nat" {
    vpc = true
}

resource "aws_nat_gateway" "natgw" { 
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.ap-southeast-1a-public.id}"

    tags = {
        Name = "NAT Gateway"
        Terraform = true
    }
}

resource "aws_subnet" "ap-southeast-1a-public" {
    vpc_id = "${aws_vpc.customvpc.id}"
    availability_zone = "ap-southeast-1a"
    cidr_block = "${var.public_subnet_cidr}"

    tags {
        Name = "Public_Subnet"
        Terraform = true
    }
}

resource "aws_route_table" "ap-southeast-1a-public" {
    vpc_id = "${aws_vpc.customvpc.id}"

    route {
        cidr_block = "${var.allow_all}"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags {
        Name = "Public_Subnet"
        Terraform = true
    }
}

resource "aws_route_table_association" "ap-southeast-1a-public" {
    subnet_id = "${aws_subnet.ap-southeast-1a-public.id}"
    route_table_id = "${aws_route_table.ap-southeast-1a-public.id}"
}

resource "aws_subnet" "ap-southeast-1b-private" {
    vpc_id = "${aws_vpc.customvpc.id}"
    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "ap-southeast-1b"

    tags {
        Name = "Private_Subnet"
        Terraform = true
    }
}

resource "aws_route_table" "ap-southeast-1b-private" {
    vpc_id = "${aws_vpc.customvpc.id}"

    route {
        cidr_block = "${var.allow_all}"
        nat_gateway_id = "${aws_nat_gateway.natgw.id}"
    }

    tags {
        Name = "Private_Subnet"
        Terraform = true
    }
}

resource "aws_route_table_association" "ap-southeast-1b-private" {
    subnet_id = "${aws_subnet.ap-southeast-1b-private.id}"
    route_table_id = "${aws_route_table.ap-southeast-1b-private.id}"
}
