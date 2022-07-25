variable "tenancy_ocid" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "my_public_ip" {
  type = string
}

variable "id_rsa" {
  type = string
}

variable "id_rsa_pub" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "private_key" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "region" {
  type = string
}

variable "egress_security_rules" {
  type    = list(map(string))
  default = []
}

variable "ingress_security_rules" {
  type    = list(map(string))
  default = []
}