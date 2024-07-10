variable "ec2_instance_connect_endpoint" {
  type = list(object({
        name                    = string
        subnet_name             = string
        preserve_client_ip      = string
        security_group_names    = list(string)
        tags                    = map(string)
  }))
}