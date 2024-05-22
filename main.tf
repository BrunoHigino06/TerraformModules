resource "aws_instance" "ec2_instance" {
    count                       = length(var.ec2_instance)
    ami                         = var.ec2_instance[count.index].ami
    instance_type               = var.ec2_instance[count.index].instance_type
    associate_public_ip_address = var.ec2_instance[count.index].associate_public_ip_address
    availability_zone           = var.ec2_instance[count.index].availability_zone
    vpc_security_group_ids      = [for sg in data.aws_security_group.security_group : sg.id]
    subnet_id                   = [for subnet in data.aws_subnet.subnet : subnet.id]
    key_name                    = var.ec2_instance[count.index].key_name
    ebs_block_device {
      device_name               = var.ec2_instance[count.index].ebs_block_device.device_name
      delete_on_termination     = var.ec2_instance[count.index].ebs_block_device.delete_on_termination
      encrypted                 = var.ec2_instance[count.index].ebs_block_device.encrypted
      iops                      = var.ec2_instance[count.index].ebs_block_device.iops
      kms_key_id                = var.ec2_instance[count.index].ebs_block_device.kms_key_id
      snapshot_id               = var.ec2_instance[count.index].ebs_block_device.snapshot_id
      throughput                = var.ec2_instance[count.index].ebs_block_device.throughput
      volume_size               = var.ec2_instance[count.index].ebs_block_device.volume_size
      volume_type               = var.ec2_instance[count.index].ebs_block_device.volume_type
    }

    tags                        = merge(
        var.ec2_instance[count.index].tags,
        {Name                   = var.ec2_instance[count.index].name}
    )
}