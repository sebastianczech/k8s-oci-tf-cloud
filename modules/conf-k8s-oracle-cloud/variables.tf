variable "id_rsa" {
  type = string
}

variable "compute_instances" {
  type = map(any)
}

variable "my_public_ip" {
  type = string
}