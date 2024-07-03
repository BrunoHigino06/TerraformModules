resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "password_secret" {
  name = "db_initial_password"
}

resource "aws_secretsmanager_secret_version" "secret_value" {
  secret_id     = aws_secretsmanager_secret.password_secret.id
  secret_string = random_password.db_password.result
}

resource "aws_db_instance" "db_instance" {
    count                   = length(var.db_instance)      
    allocated_storage       = var.db_instance[count.index].allocated_storage
    db_name                 = var.db_instance[count.index].db_name
    identifier              = var.db_instance[count.index].identifier
    engine                  = var.db_instance[count.index].engine
    engine_version          = var.db_instance[count.index].engine_version
    instance_class          = var.db_instance[count.index].instance_class
    username                = var.db_instance[count.index].username
    password                = aws_secretsmanager_secret_version.secret_value.secret_string
    parameter_group_name    = var.db_instance[count.index].parameter_group_name
    skip_final_snapshot     = var.db_instance[count.index].skip_final_snapshot
    db_subnet_group_name    = var.db_instance[count.index].db_subnet_group_name
    publicly_accessible     = var.db_instance[count.index].publicly_accessible
    vpc_security_group_ids  = [for name in var.db_instance[count.index].security_group_name : data.aws_security_group.security_group[name].id]
    tags                    = merge(
                              var.db_instance[count.index].tags,
        {name               = var.db_instance[count.index].name}
    )
}