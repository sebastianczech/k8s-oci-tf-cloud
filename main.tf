terraform {
  cloud {
    organization = "sebastianczech"

    workspaces {
      name = "k8s-oci-tf-cloud"
    }
  }

  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

provider "oci" {
  tenancy_ocid          = var.tenancy_ocid
  compartment_ocid      = var.compartment_ocid
  user_ocid             = var.user_ocid
  private_key           = var.private_key
  fingerprint           = var.fingerprint
  region                = var.region
}

resource "oci_core_vcn" "internal" {
  dns_label      = "internal"
  cidr_block     = "172.16.0.0/20"
  compartment_id = var.compartment_ocid
  display_name   = "VNC TF Cloud"
}