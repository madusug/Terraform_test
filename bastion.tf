resource "aws_instance" "bastion" {
  ami = data.aws_ami.bastion.id
  instance_type = var.bastion_instance_type
  key_name = aws_key_pair.management.id
  vpc_security_group_ids = [ aws_security_group.bastion_host.id ]
  subnet_id = element(aws_subnet.public_subnets, 0).id
  associate_public_ip_address = true

  tags = {
    Name = "bastion"
  }
}

resource "aws_key_pair" "management" {
  key_name = "management"
  public_key = file(var.public_key)
}

data "aws_ami" "bastion" {
  most_recent = true
  owners = [ "amazon" ]

  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-x86_64-ebs" ]
  }
}

