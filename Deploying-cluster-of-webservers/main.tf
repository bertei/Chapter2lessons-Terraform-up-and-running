provider "aws" {
    region = "us-east-1"
}

resource "aws_launch_configuration" "test-launch-configuration" {
    ami                     = "ami-09cd747c78a9add63"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.test-sg.id] 

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    #Required when using a launch configuration with an auto scaling group
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "test-asg" {
    launch_configuration = aws_launch_configuration.test-launch-configuration.name
    vpc_zone_identifier = data.aws_subnets.default.ids #pulls the subnet ids out of the aws_subnets data source and tells ASG to use those subnets

    min_size = 1
    max_size = 2

    tag {
        key     = "Name"
        value   = "asg-ec2"
        propagate_at_launch = true ##Enables propagation of the tag to Amazon EC2 instances launched via this ASG
    }
}

resource "aws_security_group" "test-sg" {
    name = "test-security-group"

    ingress {
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}