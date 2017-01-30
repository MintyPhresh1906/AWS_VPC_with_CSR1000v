resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.vpc_NAME}"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

/*
  Public Subnet
*/
resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "us-east-1a-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Private Subnet"
    }
}

resource "aws_route_table" "us-east-1a-private" {
    vpc_id = "${aws_vpc.default.id}"

#    route {
#        cidr_block = "0.0.0.0/0"
#        network_interface_id = "${aws_network_interface.G2.id}"
#    }

    tags {
        Name = "Private Subnet"
    }
}

resource "aws_route_table_association" "us-east-1a-private" {
    subnet_id = "${aws_subnet.us-east-1a-private.id}"
    route_table_id = "${aws_route_table.us-east-1a-private.id}"
}

/*
  CSR1000v Instance
*/
resource "aws_security_group" "SG_G1_CSR1000v" {
    name = "SG_G1_CSR1000v"
    description = "Allow Traffic into the CSR1000v"

    ingress {
        from_port = 4500
        to_port = 4500
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 500
        to_port = 500
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "SG_G1_CSR1000v"
    }
}

resource "aws_security_group" "SG_G2_CSR1000v" {
    name = "SG_G2_CSR1000v"
    description = "Allow Traffic into the G2 CSR1000v"

    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "SG_G2_CSR1000v"
    }
}

resource "aws_instance" "CSR1000v" {
    ami = "ami-67696e0d"
    availability_zone = "us-east-1a"
    instance_type = "${var.CSR1000v_instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.SG_G1_CSR1000v.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
	private_ip = "${var.G1_static_private_ip}"
    source_dest_check = false

    tags {
        Name = "${var.vpc_NAME}"
    }
}

resource "aws_eip" "CSR1000v" {
    instance = "${aws_instance.CSR1000v.id}"
    vpc = true
}

#resource "aws_network_interface" "G2" {
#	subnet_id = "${aws_subnet.us-east-1a-private.id}"
#	private_ips = ["${var.G2_static_private_ip}"]
#	security_groups = ["${aws_security_group.SG_G2_CSR1000v.id}"]
#	source_dest_check = false
#	attachment {
#		instance = "${aws_instance.CSR1000v.id}"
#		device_index = 1
#	}
#}