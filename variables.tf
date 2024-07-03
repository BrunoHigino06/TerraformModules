variable "db_instance" {
  type                      = list(object({
    name                    = string
    allocated_storage       = string
    db_name                 = string
    identifier              = string
    engine                  = string
    engine_version          = string
    instance_class          = string
    username                = string
    parameter_group_name    = string
    skip_final_snapshot     = string
    db_subnet_group_name    = string
    publicly_accessible     = string
    security_group_name     = list(string)
    tags                    = map(string)
  }))
}