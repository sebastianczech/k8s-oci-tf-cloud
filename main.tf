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
  config_file_profile   = var.profile_name
}
