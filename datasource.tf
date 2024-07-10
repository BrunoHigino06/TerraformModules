locals {
    subnet_unique_names     = flatten([for connect_endpoint in var.ec2_instance_connect_endpoint : connect_endpoint.subnet_name])
    security_group_names    = flatten([for connect_endpoint in var.ec2_instance_connect_endpoint : connect_endpoint.security_group_names])

}

# Data subnets
  data "aws_subnet" "subnet" {
    for_each    = { for subnet in local.subnet_unique_names : subnet => subnet ...}

    filter {
      name      = "tag:unique_name"
      values    = [each.key]
    }
  }

# Data Security group
  data "aws_security_group" "security_group" {
    for_each = { for security_group in local.security_group_names : security_group => security_group ...}

    filter {
      name = "tag:Name"
      values = [each.key]
    }
  }