
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

data "aws_security_groups" "node_group_one" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Purpose"
    values = ["node_group_one"]
  }
}

data "aws_security_groups" "node_group_two" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
  filter {
    name   = "tag:Purpose"
    values = ["node_group_two"]
  }
}