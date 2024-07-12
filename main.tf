#key pair resources
resource "tls_private_key" "tls_private_key" {
  count = length(var.key_pair)  
  algorithm = var.key_pair[count.index].algorithm
  rsa_bits  = var.key_pair[count.index].rsa_bits
}
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_pair[count.index].key_name
  public_key = tls_private_key.tls_private_key.public_key_openssh
}

resource "local_file" "local_file" {
  content         = tls_private_key.tls_private_key.private_key_pem
  filename        = "${var.key_pair[count.index].key_name}.pem"
}