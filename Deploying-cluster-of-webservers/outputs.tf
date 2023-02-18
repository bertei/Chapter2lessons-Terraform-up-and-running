output "ec2_public_ip" {
    value = aws_instance.test-ec2.public_ip
    description = "The public ip address of the web server"
}