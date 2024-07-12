variable "key_pair" {
    type              = list(object({
      key_name        = string
      algorithm       = string
      rsa_bits        = string
      file_permission = string
    }))
}