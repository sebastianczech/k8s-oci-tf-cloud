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

variable "instance_count" {
  type = number
}

variable "availability_domains" {
  type = list(number)
}

variable "egress_security_rules" {
  type    = list(map(string))
  default = []
  validation {
    condition     = (length(var.egress_security_rules) > 0 && anytrue([for rule in var.egress_security_rules : rule["destination"] == "0.0.0.0/0"]))
    error_message = "At least 1 rule should be defined for 0.0.0.0/0 destination"
  }
  validation {
    condition     = (length(var.egress_security_rules) > 0 && alltrue([for rule in var.egress_security_rules : can(rule["protocol"])]))
    error_message = "Every item in the egress security rules has to contain procotol"
  }
  validation {
    condition     = (length(var.egress_security_rules) > 0 && alltrue([for rule in var.egress_security_rules : can(rule["destination"])]))
    error_message = "Every item in the egress security rules has to contain destination"
  }
  validation {
    condition     = (length(var.egress_security_rules) > 0 && alltrue([for rule in var.egress_security_rules : can(rule["destination_type"])]))
    error_message = "Every item in the egress security rules has to contain destination_type"
  }
  validation {
    condition     = (length(var.egress_security_rules) > 0 && alltrue([for rule in var.egress_security_rules : can(rule["description"])]))
    error_message = "Every item in the egress security rules has to contain description"
  }
}

variable "ingress_security_rules" {
  type    = list(map(string))
  default = []
  validation {
    condition     = (length(var.ingress_security_rules) > 0 && anytrue([for rule in var.ingress_security_rules : rule["source"] == "0.0.0.0/0"]))
    error_message = "At least 1 rule should be defined for 0.0.0.0/0 source"
  }
  validation {
    condition     = (length(var.ingress_security_rules) > 0 && alltrue([for rule in var.ingress_security_rules : can(rule["protocol"])]))
    error_message = "Every item in the ingress security rules has to contain procotol"
  }
  validation {
    condition     = (length(var.ingress_security_rules) > 0 && alltrue([for rule in var.ingress_security_rules : can(rule["source"])]))
    error_message = "Every item in the ingress security rules has to contain source"
  }
  validation {
    condition     = (length(var.ingress_security_rules) > 0 && alltrue([for rule in var.ingress_security_rules : can(rule["source_type"])]))
    error_message = "Every item in the ingress security rules has to contain source_type"
  }
  validation {
    condition     = (length(var.ingress_security_rules) > 0 && alltrue([for rule in var.ingress_security_rules : can(rule["description"])]))
    error_message = "Every item in the ingress security rules has to contain description"
  }
}