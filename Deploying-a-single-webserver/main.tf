provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "test-ec2" {
    ami             = "ami-0fb653ca2d3203ac1"
    instance_type   = "t2.micro"

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