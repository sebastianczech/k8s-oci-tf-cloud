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
      ### use to specify version of OCI provider
      version = "~> 4.118.0"
    }
  }
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  private_key  = var.private_key
  fingerprint  = var.fingerprint
  region       = var.region
}
