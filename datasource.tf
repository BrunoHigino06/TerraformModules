locals {
    security_group_names  = flatten([for security_group in var.db_instance : security_group.security_group_name])
}

# Data Security group
  data "aws_security_group" "security_group" {
    for_each = { for security_group in local.security_group_names : security_group => security_group ...}

    filter {
      name = "tag:Name"
      values = [each.key]
    }
  }