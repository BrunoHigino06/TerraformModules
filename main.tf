resource "aws_ec2_instance_connect_endpoint" "ec2_instance_connect_endpoint" {
    count               = length(var.ec2_instance_connect_endpoint)  
    subnet_id           = data.aws_subnet.subnet[var.ec2_instance_connect_endpoint[count.index].subnet_name].id
    preserve_client_ip  = var.ec2_instance_connect_endpoint[count.index].preserve_client_ip
    security_group_ids  = [for security_group_name in var.ec2_instance_connect_endpoint[count.index].security_group_names : data.aws_security_group.security_group[security_group_name].id]
    tags                = merge(var.ec2_instance_connect_endpoint[count.index].tags,
        {Name           = var.ec2_instance_connect_endpoint[count.index].name}
    )
}