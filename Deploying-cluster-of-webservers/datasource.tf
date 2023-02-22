#Fetches default vpc
data "aws_vpc" "default" {
    default = true
}

#Pulls the subnet ids out of aws_vpc data source
data "aws_subnets" "default" {
    filter {
      name      = "vpc-id"
      values    = [data.aws_vpc.default.id]
    }
}