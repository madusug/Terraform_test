resource "aws_security_group" "bastion_host" {
  name = "bastion_sg_${var.vpc_name}"
  description = "Allow SSH from anywhere"
  vpc_id = aws_vpc.default.id

  egress = [
    {
        description = "for all outgoing traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        prefix_list_ids = []
        security_groups = []
        self = false
  }
  ]

  ingress = [
    {
        description =  "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = false
  }
  ]

  tags = {
    Name = "bastion_sg_${var.vpc_name}"
  }
}

data "http" "ip" {
  url = "http://ipv4.icanhazip.com"
}

