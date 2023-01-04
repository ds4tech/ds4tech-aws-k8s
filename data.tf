
data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["education-vpc"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}

variable "security_group_id" {
  default = "sg-0108e8725ea543dde"
}

data "aws_security_group" "node_group_one" {
  id = var.security_group_id
}
data "aws_security_group" "node_group_two" {
  id = var.security_group_id
}