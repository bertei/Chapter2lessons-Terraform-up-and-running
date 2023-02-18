provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "test-ec2" {
    ami                     = "ami-09cd747c78a9add63"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group] 

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF
    user_data_replace_on_change = true
    tags = {
        Name = "test-ec2"
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