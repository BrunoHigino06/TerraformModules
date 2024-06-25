locals {
  subnet_unique_names     = flatten([for subnet_group in var.db_subnet_group : subnet_group.subnet_names])
}

data "aws_subnet" "subnet" {
  for_each = { for subnet in local.subnet_unique_names : subnet => subnet ... if subnet != null}

  filter {
    name = "tag:unique_name"
    values = [each.key]
  }
  
}