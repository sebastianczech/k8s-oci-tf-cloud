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
      # version = "<= 4.79.0"
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

module "infra-k8s-oracle-cloud" {
  source  = "sebastianczech/infra-k8s-oracle-cloud/oci"
  version = "0.0.4"

  compartment_id = var.compartment_id
  my_public_ip   = var.my_public_ip
  id_rsa_pub     = var.id_rsa_pub
}

module "conf-k8s-oracle-cloud" {
  source = "./modules/conf-k8s-oracle-cloud"

  compute_instances = module.infra-k8s-oracle-cloud.compute_instances
  lb_id             = module.infra-k8s-oracle-cloud.lb_id
  subnet_cidr       = module.infra-k8s-oracle-cloud.subnet_cidr
  my_public_ip      = var.my_public_ip
  id_rsa            = var.id_rsa
}
