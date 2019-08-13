provider "aws" {
	region = "ap-southeast-1"
}

resource "aws_vpc" "vpc_devops" {
	cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
	vpc_id = "${aws_vpc.vpc_devops.id}"
}

resource "aws_subnet" "sub_public_devops" {
	vpc_id = "${aws_vpc.vpc_devops.id}"
	
	cidr_block = "10.0.0.0/16"
	availability_zone = "ap-southeast-1a"
}

resource "aws_security_group" "sg_devops" {
	name = "sg_devops"
	description = "Allow SSH and HTTP access"
	vpc_id = "${aws_vpc.vpc_devops.id}"

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "tls_private_key" "kp_devops" {
	algorithm = "RSA"
	rsa_bits = 4096
}

resource "aws_key_pair" "generated_key"{
	key_name = "ec2_devops_pub"
	public_key = "${tls_private_key.kp_devops.public_key_openssh}"
}

resource "aws_route_table" "ap-southeast-1" {
	vpc_id = "${aws_vpc.vpc_devops.id}"
	
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.gw.id}"
	}
}

resource "aws_route_table_association" "ap-southeast-ap1" {
	subnet_id = "${aws_subnet.sub_public_devops.id}"
	route_table_id = "${aws_route_table.ap-southeast-1.id}"
}

resource "aws_instance" "ec2_devops" {
	ami = "ami-03b6f27628a4569c8"	
	instance_type = "t2.micro"
	key_name = "${aws_key_pair.generated_key.key_name}"
	subnet_id="${aws_subnet.sub_public_devops.id}"	
	vpc_security_group_ids = ["${aws_security_group.sg_devops.id}"]
}

resource "aws_eip" "ec2_devops_ip"{
	instance = "${aws_instance.ec2_devops.id}"
	vpc = true
}

output "ip" {
	value = aws_eip.ec2_devops_ip.public_ip
}

output "private_key" {
	value = tls_private_key.kp_devops.private_key_pem
}
