resource "aws_launch_configuration" "asg" {
  image_id = "ami-0ccce392766afada3"
  instance_type = var.bastion_instance_type
  key_name = aws_key_pair.management.id
  security_groups = [ aws_security_group.instance.id ]

  user_data = <<-EOF
                #!/bin/bash
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                brew tap databricks/tap
                brew install databricks
                EOF

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.asg.name
  vpc_zone_identifier = [for subnet in aws_subnet.private_subnets : subnet.id]

  min_size = 2
  max_size = 3

  tag {
    key = "Name"
    value = "terrraform-asg-example"
    propagate_at_launch = true
  }
}