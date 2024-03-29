variable "region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  default = "10.0.0.0/24"
}

variable "vpc_name" {
  description = "vpc_name"
  type = string
  default = "test_vpc"
}


variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type = number
  default = 8080
}

variable "instance_name" {
    description = "Name tag for the EC2 instance"
    type = string
    default = "james_test_instance"
  
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "public_subnets_count" {
  type = number
  default = 1
}

variable "private_subnets_count" {
  type = number
  default = 2
}

variable "availability_zone" {
  description = "Availability zone for spinning up the VPC subnet"
  type = list(string)
  default = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}

variable "public_key" {
  default = "test1.pem"
}
