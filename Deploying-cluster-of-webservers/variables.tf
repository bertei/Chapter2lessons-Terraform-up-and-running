variable "server_port" {
    description = "The port the server will use for HTTP requests"
    type        = number
}

variable "alb_name" {
    description = "App load balancer name"
    type = string
}

variable "instance_security_group_name" {
    description = "The name of the SG for the EC2 instances"
    type = string
}

variable "alb_security_group_name" {
    description = "The name of the SG for the ALB"
    type = string
}